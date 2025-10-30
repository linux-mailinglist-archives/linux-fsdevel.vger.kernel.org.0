Return-Path: <linux-fsdevel+bounces-66471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2569C2037C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BED1A23A2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A433F363;
	Thu, 30 Oct 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XNmc0Dl/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bp0R14Oq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4872DE71A;
	Thu, 30 Oct 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830596; cv=fail; b=gTt2HTuWxYOWe8+lL3LYOEu/9bQVmbpkNacoyNONdqddnV0BtyfWQI5ZDhxoCk6bVwDPQnkYg3TpKOmyTSMb+8HMA4R4mzQvu+/NRw2mqJAdnJJNNiWsAFStFZeqQmAI7A+yZ3a7CgbHsSltgiYFKrw+9yc6HrM1bdQKzAJMbFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830596; c=relaxed/simple;
	bh=Mmc/KnXhJAQtlMuoKrgYKNhkc0xUBy6OXLvQPGGZPmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wm9empGV+91Ka6WeFvfBTmDbKBp7BCbrVJT9+lvS+TLNpC7hO0r541dNi7AVVb+Xy8I1HEX7/Z0vIRMyCJ2A1kQkVuGMCXHZaDpHZRdPj3gpgWmPxxNkpAAcE7m7qMiGu8wzBno4ny4sYViHN9TJmCcZRYjBWVKivjH0vmwTWcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XNmc0Dl/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bp0R14Oq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UDCO8K024360;
	Thu, 30 Oct 2025 13:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6HfjR91SKTaZ0TNGfIUG8W/7mUs1/uMA3zGmju4GM8M=; b=
	XNmc0Dl/UmNKtOC26YFY1oFzdOAjbwH1ScMplfgwQCLHslFyYVz/y6X4gXoOQ/bo
	3+vx8JIIDn1j2GSMmHPlz1twvPoVAJBFVe/ftCzZegy5QPntycFpVRMJ6ug5GG/g
	h3ub6JEU6XphENheXifyPtngizN+F4zwk+1kM3nwcmZzYi1K0doY9uFACQ15wW55
	sz8XUE4OkKzAt09g7GoBGjiz0DxU0c3NuAiQgK1mZUmozl6L6NwoogXI3mHqDf/0
	tCDNRGqQZYdLPz7ymoH/Z2Fym+JDWNKIBovLPMuVQkh9Xs4YC3NNPcT1uDAXh3xW
	TdBn8tcykyKhutOvJm58Kw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a476hr851-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:22:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UCjS8J027654;
	Thu, 30 Oct 2025 13:22:39 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q92maf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 13:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8xmr3UIG3Hbhy6vePd0q7MTAw3kOnNLMMGfxCFhI8EfPQaqNssOALeJtdMXvfcYI/GbPKULtdbJcwt0QF9Q6aovepOvTXMGQnYQzSB1QfP4AsLv3wrJjJbkHEdbA3HrNhA9Bmvwgkv+Dc2B/ZsEMvSvyH8G42mr3vZLgn/MmHX+VYn+y4HQ5LyPdBECLroHkdNYQ4taYoN685tCTPkJTuZqtNfVXm1cB4RQaSb0IwvAUewMrem9BItzy0VFTJiCvvOsBbaKIyZ9/IqIowRgb0MKw0MyxVu3YwzRVfNMkkimyfvin+ycHPxfYFR7Yjef9z4+jGN5whmNbNVYVVslFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HfjR91SKTaZ0TNGfIUG8W/7mUs1/uMA3zGmju4GM8M=;
 b=Qx4lnCGDs/EEF8/zpuBGr/mFZZyq5+4KjXBs/jr1m2gTd9r0EyrJV5J+WIvPDT+7VlMGMhfBM4mEXiwjFOffHun3hLtkXrjdsoh/k1ItGHFfBasechcDtwqw2jYDbOX4L6RszPKFElr8LnyvPJloBS7hoGrc6clDecEzYq6BZyO1J6fEUAtfjpeeebpfNCtEgh/x5zwF9Brmsb1kUeRilpZ+G/41SwHUgKBK+iW+dQ08ScBbWRDfoG3Er/oRPryQGaee/139fOTP2pI3b5QLfTgQxYaReFykfOidsWpKqK+1cSt9uv/b2R0Pydsda/r0IzOc9ouq3GUPKbafs7zo1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HfjR91SKTaZ0TNGfIUG8W/7mUs1/uMA3zGmju4GM8M=;
 b=Bp0R14OqcrVt7D3zWGF9ogTgTb0KXNPGQ3N+Bd4CzpoWH2V0lhTV2JhZp+1/ns1t2rlNr8PRU0zD69xaYWqaxCvtLK6skrlvVKO8cG+EK1oQshM56CrZtc9CtQPhYY2pM5OIE9YHyQW3XL12ix1mUBRpbai0DfA4SkpvLZi6XdQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM3PPF334FD9217.namprd10.prod.outlook.com (2603:10b6:f:fc00::c19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 13:22:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 13:22:32 +0000
Message-ID: <c20d10da-08ef-4e9a-aff9-a7a9e6efe82b@oracle.com>
Date: Thu, 30 Oct 2025 09:22:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] VFS/nfsd/ovl: introduce start_renaming() and
 end_renaming()
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Carlos Maiolino <cem@kernel.org>,
        John Johansen
 <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Darrick J. Wong"
 <djwong@kernel.org>, linux-kernel@vger.kernel.org,
        netfs@lists.linux.dev, ecryptfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
References: <20251029234353.1321957-1-neilb@ownmail.net>
 <20251029234353.1321957-10-neilb@ownmail.net>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251029234353.1321957-10-neilb@ownmail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:610:20::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM3PPF334FD9217:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa954cc-2669-4e93-4030-08de17b7622e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ZGRsQ2ZzSTBQMWlCWkY1OFZ2QnFQem1wRnN2ZUhvNWdvZjF5aEhUZDFkVGVi?=
 =?utf-8?B?WFRuR3ZWckxFbllBVHZ5Z1NQYUZtZEQ0MFFOU3N2UjQwdGtoYitEQThicDNz?=
 =?utf-8?B?a3EzbnhBOElWQWVhalMrOGJ1a0twTEVJU1poRmg4NWIzemJnZ1dyUzRXN0xl?=
 =?utf-8?B?cThBUE1KRFg2NFlMT0lQWXNua1BEZUxLbmdSbTBreG1sZHZVTFVtOFJMNXRj?=
 =?utf-8?B?Nk10blcxdnBDbnFURHNMdUp2bFNZSlZveWxiVkszS1dsNGZxRG42bXB3MDlP?=
 =?utf-8?B?ZHJOUWYxS1RLc1hqU2cwRUJmT2pHYk5XMTF2N08vTU9ERnlYbExyNWRoM01X?=
 =?utf-8?B?bXBPZ1FzVWNiY3ZTV1F3ZWhid2xram1YNlM5L0dtSHZrWGM0eEFxaVBNMVpH?=
 =?utf-8?B?dmZpa3dVYlJHUjBxeFl0RCs2SjlDWCtsSkUvdm9ldllVbjUrdjdkZGcrbERa?=
 =?utf-8?B?OTFLRjZraXgvVUNxakRFQXZFbGNJdjIyVnMzemMzRlUvUWN5eit6dzA0Q3E5?=
 =?utf-8?B?ZU9uMi9TUDRLRHRBOFJ1SHgyczhGZitQemdqMVNGSzkxNVFraE44aG5ZOWQ3?=
 =?utf-8?B?T05iVHJCQ1JuVHErTkFYZzRiRjd0Q2ZMVFl2RjR4L2NYSTZuM0hCK3ZjNkZ4?=
 =?utf-8?B?Rm15SnREY0xPdituek9JTlgyc3pUbG8vcThXeXBLMlNOY1lGdGpOOFRtMlhi?=
 =?utf-8?B?cVc2cUg0VElBUklRekFiTldQNE0xd1N3TUhUa1V3WFdITUg2MXdXM01nb1h3?=
 =?utf-8?B?SGhkRWxXTThBNWFuWTRhb2Jsb205K0pUK1JCN1czNnVienUzR2g3alBnS21m?=
 =?utf-8?B?d3JDWDVPRlR1MUxBcXRZODdQRjluU2QxRjBCdlFSalRoN21UZXhDNW9oZWd3?=
 =?utf-8?B?Nld4WHk4TFVmRlV2Tk9DNndheS9WOENQdXliWWQwMnRWYlJJS3p5UjNkVEZi?=
 =?utf-8?B?SVZCWDlteGZtRElvd2wxNHNocSs3blg0M2dOb1NraW1LdGVockhUYmtuZDY2?=
 =?utf-8?B?M0V1ck1DM0ZiUmw2WGV6bmtLYjNPL3FCWERLT29lcjdIazNxN2ZtT2YxSHpn?=
 =?utf-8?B?S0MxV0F6dnJ4N1JNZHRWTlp4T0xmZStPVm41ckhpMmtqb29LcXNqb3VTWkR0?=
 =?utf-8?B?ZHk2dGlRR1BIdGxxVWgwMWp3WGc3S3l5U3lENkdLVDV3UzRLMFN3ZE1ta2s5?=
 =?utf-8?B?TzRpcEFmUWxTSUtYenhaMDhaaktYdHJ3SDhHNVdTR2lXTDNOT2tYTjdLSFBh?=
 =?utf-8?B?T0VJa1c0S0FvaXk4SncwVlJsQSt6ZTRYNkRFR1RDcVF4WFJBeE93cWxVNGho?=
 =?utf-8?B?WkNiOFM1M0c2QUZVQ2lZOFc2b05pdVNIYWVQcTl6Y0l2R1NKeC9uTUpFZTJO?=
 =?utf-8?B?cXRTQmRSc3lIa1VCNG9WN21HNHlUMENPUjRGUlFxMmdJVlJQMGRUMEQ2aW1L?=
 =?utf-8?B?T1FSckhQTklYUkZWSC9BcXZSZE4zQ1U2OGU3dVZWUkdyVWxYa3Z6STFVdWhx?=
 =?utf-8?B?TVM0SXNvNldSbHJzOTRkTWl5M2JoSkRBRjBoV09sNHNzTEZpbSsydXQ4MWdJ?=
 =?utf-8?B?a1hxZTN3N04veWR6OEU5cWxBNTN6amFIMHdWeThsT3lZN3g3OXNaTXZyMDY1?=
 =?utf-8?B?OXFsQUF6Y3pLWTRBSFJxNTJzakZ2bVJDVk5aVmJDbjE4LytrMXR3ZTFZMTd5?=
 =?utf-8?B?eXBYZHlUeFo4dWVmN1A0ZGlTeDlyckRCVFRmYmdOaWEvbDZRcDBGUTUraDk1?=
 =?utf-8?B?SzhocW8yWCs1endOa0xTU3dpcmdrSlUvckNDOUlDUlQ3Z09Nam5mWks4YVNO?=
 =?utf-8?B?eHFTTFo0NTlQbWNRdXBaMXlhU0dQTDRseVNHakJvTlNHY2V1RWZIUWpvbitF?=
 =?utf-8?B?T01MMG9zOUJzbXVZVENnR3BFVnJEWTdyZHNZMXB4S1ZJdTZxdnl6Y0JUM1lL?=
 =?utf-8?Q?Z6Hy19RoeLwBR447wbZ5PAYtqryYmT2c?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b3ZiZEU5UnEwaTBpYS81N2RJbUhrS25wbjRPWXhRdnBxaXBjUVRKM0tNTEJL?=
 =?utf-8?B?QmlOcUs4aDdLL1BEaHNRakgxYU5oMlNJekFaS3phOFdEVENxZ2ZsMjJMOEF3?=
 =?utf-8?B?bzdNa0tHbG0rblFubGxld2FBRTlaYXduTWQ1ajVKQk1TMWFxUzVxeEk4bWVx?=
 =?utf-8?B?VVJBUmFtSVBYVFFRYnN2a25IMmRPR2NoYmFmMTZUNnFmOUorUTZnSElXWW5X?=
 =?utf-8?B?NmpXYU9wRUxDR0JscDBKV0RySDZjdzVoZEU3VGc3dTNSdFJxRWY4ellKdjht?=
 =?utf-8?B?RE9LRDE3YnpjQVV4eWlhQ1dPZTZDT1hXTmVxa2V6RDNnS0dMY1VCNkluTFZF?=
 =?utf-8?B?OXdJbTdmWks2RHBkRmpJVG00NXF3eXpjcHduaHNsSXdCSll4WmZNcldTKzNt?=
 =?utf-8?B?UTI1M05qQVJ6QUtjMFB1MnVwL09Za2NpMzUvK0dXVUd1OGVpSzJmZjY5NFFz?=
 =?utf-8?B?RlJvOUVEcGRVQjRNVnEzVHh6VHJNNUlGcmo4dzYyTTVGU0ZHZUxOemhablFu?=
 =?utf-8?B?SlB1TmtxNXpJdTByeUN1TXYwcWIrZXB0dlNVbW9qYlVHVXJ4bWxpNUozcThQ?=
 =?utf-8?B?VjRTekI5M1RTa2w3aGxYbk9INHR6ekFKckVNVHBCcmNrM25sYkdtYTgxNkZk?=
 =?utf-8?B?dHVQOUlyaitGeWlJaVhjOHFpUS9pZWVyWlVSTVFPUWcxaHZmMG9FbHVXUGpK?=
 =?utf-8?B?U1dyVjNmWXlnZ1c4REwwZmVQcTE3Q0hFM2YzMHJMUHUzbWkwTkVUQktNT0Fv?=
 =?utf-8?B?MmM2VytFMm5yQ2cyd2J0TnVqaWtKaTlWNFJUT2pnYVRWR3NHWnNnaWJ1VGtv?=
 =?utf-8?B?VlliMEo0OTdqNFFDYnYrVGFuSllRUFY0TzRnbnVBbWZhV25vS0JYaVJNQUJ6?=
 =?utf-8?B?cWx6TXllUVl3S1RCOEtnNGpyL0Q2ZnY5R3piNGxkWlJwaERVWVFObHRFUG5V?=
 =?utf-8?B?NVcwRDBEMFArZElIYXVRajZRTUZkSVF4YnVYNXUrQ3J3T0tSMVdOWEhrM1pK?=
 =?utf-8?B?RFh4VzVDMC9mQ3M0djA0ZytLWGlsbTZUbEpOek1mV3dxY0dkYmFWSTNrNlI5?=
 =?utf-8?B?OEJKNnVRSDFlUEpEMEJkWTZNMDhHZUQwWFB3eHlCUDV2ajluMG9pekMwcm16?=
 =?utf-8?B?aURNa0F1TnZId1dyemlXZ2RaOVhzTXQ3OStSUTNMRXpDa1BUelkzeHpNU3lq?=
 =?utf-8?B?MG5FY3k2NTFCM3EzdjZFQjkxYmQzVmxVdlB0MlowMmlpQmtZQnY1SmxIYkox?=
 =?utf-8?B?MU1XMkhMb2hIOHN6Y3p4QXlYYmlLQTd5SjZsZWl6MGRBRnJsUklNL21IZUF3?=
 =?utf-8?B?QmlGS1hTaG1MV2FnZnZqOU1idU11VkF4L09Vc3d3aUU5L1llR3h5VkJDa0pq?=
 =?utf-8?B?aFNubWg1TlpBM3JsRC9kdzQ3a0FRa2gvaVIzNlVyUUp5Q3M5VTZnMlBUTFBa?=
 =?utf-8?B?em9ERUFHSEIwdEwvK1BYRTh5MEY0b05GVTVUTFJpMFpvQVFqNDJqY1hCaVhH?=
 =?utf-8?B?MERpSVlpTWdTNEY4WjMxaUYrc0RHSXZXOCtNb0ZZSUNRbldzOTBDTjh0WjhS?=
 =?utf-8?B?S3hFN2h6b3NmMjZOSGpva0pGUjFtQ0Fza2tCTkl3aVJnY2R3ZWFwNy9qMTdK?=
 =?utf-8?B?aXlYeW1WTmwyckNEQWtqRHVhOTZnbTZrMWxWM0M5Vm9wa29jTU96N1ZIUUs1?=
 =?utf-8?B?UGVUTE1EZE12ODAxMTgrK2wzaHFJOVRoeUw5MjA5cTR1enFyVjFLKzlITGUy?=
 =?utf-8?B?ZDQzblVlVGtuL25xd1BhRHp2anVUV0hqdGRsb0dlUjF0bzJML2g2eGVEVGJv?=
 =?utf-8?B?eE4rWE1JMC94aGFjYW1EZ1h1U0hmTVEwZXlBcGF1WExGbXpHNlU3T1hEYkFQ?=
 =?utf-8?B?ZXpxUno5QU9aSDd5VitySXo3cjYwWkhVUWVvVnRScVhvUXdmbTZzRHkxYzF6?=
 =?utf-8?B?cWdkaURMNllPYWwzemVBRFFvazNoa29sWER3dzlTM0pGcCtNLzdRcVM3MmMy?=
 =?utf-8?B?ZG5udFZ6VkpZRUlJKyt1OHN2Rkg3Tm5GWUZpTmZWK096VkgxWVFZeW5rRVl0?=
 =?utf-8?B?TmV6L1FwOVgwSTRRNi9QS1dOWjgvUUU2QWRhTUhsa1FwOE5IT01qb2JRZUVo?=
 =?utf-8?Q?JM+iOE1c1ENthACnMA/x2abcJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NN5IQMxB7F0rhCiduLgMvoqT8XHuxuk5J9aLxAnY2UprnT6qNJP1Qnl7ArTlLeVDLtEUHmvMB+01ACN/flJDSw2C4NPBJ0rGrlC3T/19yqsFQA1KgLD1zg/1pH/RMpBbKclU9BuiyPgTB6SsYhSN/M4AIGPZ+WfwDBZd7TkkEGuIBOH8/ciLDNrBqyF3OwbrwFZ55lJ2WaOUnqvA2bdlf6OdWXuOEAKaYPxui7u49rjcmACoQrnJQDKauQfhBq+i+5dtFWNIQwYqnGlvXi5FNxi7AEvMxIJsqtJpcX3Au+ORKJntHnTo/OKwrFec4SvfDlazNKUNDRnDaOMHFeMbiD5JdC7o9C6RnQCGOa5W/+kAIOD0MqaKx0Dzlyci1hpAlCape70jBb0khl+USxE0HfiuH1L81YIrB3+3GdXBF8Bk5sf9xiOVw30ufsj7YLv90idMcaFZw44tXSKgGcIu+tXkGp81HObHLGZ0IqNIyIHo47/j0NelYHhfCNQS5+s5lvbY1ee68eg4UQ23/G4L1/vkliat3OlUvocNdMPXXrsXv1xPYRVKIo583xmwO0OoGH/vKe6Zp8aKG9m7SM1Q5mctbwXN4XtmBfm0j0IhuPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa954cc-2669-4e93-4030-08de17b7622e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:22:32.8865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rn5kLAm4wzKralDXfYe7halVEWElOEA/oL3uJDv/z/C6SAhVlpe/0ruF6K1dN+T2JT9+eGpipExlA511rR1clw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF334FD9217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300108
X-Proofpoint-ORIG-GUID: C2PTMJYJHxeHL7vYc-sMK5DpOuyeNzYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MyBTYWx0ZWRfX/Tzbzkv08FHo
 Zw/TPmGvsKyIPvQ58VXUP9vrQ1mP8247620y2uy1HiJdL9TAZSi5/1eHslG/c/PBmKxyVvy5dwL
 WZPe8fSaxKHbQxWK62CVbEGC5YFSZG9uFAyDQzA2Vo8UkTJqKRNK6kvhvQqlkhRBaxOSJSUKT8J
 WarypjQ8FLOSFT9oCLBJzVHSE7p6mksF4HJm6Zty338fOLLVEUdXGU9pqpSas2Z73VH8Im8Jvep
 TTMwBVBRnrkGGR8UtwyPedNm/arknTWSSOZiFYlmBkTic7u2b6NRJ5wfbVkvj+WFkxHYcaYHJoG
 dsbij48rvig5P73FMLN6u4jrC5rcgpBycgBJW9gHEU3686QQ0OoEvtXj8+oz4UFfqj5ApKTiNQw
 XYBrv5TTESlEejW36kxeDGeiwFdDU4d3gS6J8QYgmtxd0s4zMdg=
X-Proofpoint-GUID: C2PTMJYJHxeHL7vYc-sMK5DpOuyeNzYr
X-Authority-Analysis: v=2.4 cv=YaywJgRf c=1 sm=1 tr=0 ts=690366a0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=tPsLzgmzpo3tGgPY_jkA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12124

On 10/29/25 7:31 PM, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> start_renaming() combines name lookup and locking to prepare for rename.
> It is used when two names need to be looked up as in nfsd and overlayfs -
> cases where one or both dentries are already available will be handled
> separately.
> 
> __start_renaming() avoids the inode_permission check and hash
> calculation and is suitable after filename_parentat() in do_renameat2().
> It subsumes quite a bit of code from that function.
> 
> start_renaming() does calculate the hash and check X permission and is
> suitable elsewhere:
> - nfsd_rename()
> - ovl_rename()
> 
> In ovl, ovl_do_rename_rd() is factored out of ovl_do_rename(), which
> itself will be gone by the end of the series.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: NeilBrown <neil@brown.name>
> 
> --
> Changes since v3:
>  - added missig dput() in ovl_rename when "whiteout" is not-NULL.
> 
> Changes since v2:
>  - in __start_renaming() some label have been renamed, and err
>    is always set before a "goto out_foo" rather than passing the
>    error in a dentry*.
>  - ovl_do_rename() changed to call the new ovl_do_rename_rd() rather
>    than keeping duplicate code
>  - code around ovl_cleanup() call in ovl_rename() restructured.
> ---
>  fs/namei.c               | 197 ++++++++++++++++++++++++++++-----------
>  fs/nfsd/vfs.c            |  73 +++++----------
>  fs/overlayfs/dir.c       |  74 +++++++--------
>  fs/overlayfs/overlayfs.h |  23 +++--
>  include/linux/namei.h    |   3 +
>  5 files changed, 218 insertions(+), 152 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 04d2819bd351..0ee0a110b088 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3667,6 +3667,129 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
>  }
>  EXPORT_SYMBOL(unlock_rename);
>  
> +/**
> + * __start_renaming - lookup and lock names for rename
> + * @rd:           rename data containing parent and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_last:     name of object in @rd.old_parent
> + * @new_last:     name of object in @rd.new_parent
> + *
> + * Look up two names and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentries are stored in @rd.old_dentry,
> + * @rd.new_dentry.  These references and the lock are dropped by
> + * end_renaming().
> + *
> + * The passed in qstrs must have the hash calculated, and no permission
> + * checking is performed.
> + *
> + * Returns: zero or an error.
> + */
> +static int
> +__start_renaming(struct renamedata *rd, int lookup_flags,
> +		 struct qstr *old_last, struct qstr *new_last)
> +{
> +	struct dentry *trap;
> +	struct dentry *d1, *d2;
> +	int target_flags = LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +	int err;
> +
> +	if (rd->flags & RENAME_EXCHANGE)
> +		target_flags = 0;
> +	if (rd->flags & RENAME_NOREPLACE)
> +		target_flags |= LOOKUP_EXCL;
> +
> +	trap = lock_rename(rd->old_parent, rd->new_parent);
> +	if (IS_ERR(trap))
> +		return PTR_ERR(trap);
> +
> +	d1 = lookup_one_qstr_excl(old_last, rd->old_parent,
> +				  lookup_flags);
> +	err = PTR_ERR(d1);
> +	if (IS_ERR(d1))
> +		goto out_unlock;
> +
> +	d2 = lookup_one_qstr_excl(new_last, rd->new_parent,
> +				  lookup_flags | target_flags);
> +	err = PTR_ERR(d2);
> +	if (IS_ERR(d2))
> +		goto out_dput_d1;
> +
> +	if (d1 == trap) {
> +		/* source is an ancestor of target */
> +		err = -EINVAL;
> +		goto out_dput_d2;
> +	}
> +
> +	if (d2 == trap) {
> +		/* target is an ancestor of source */
> +		if (rd->flags & RENAME_EXCHANGE)
> +			err = -EINVAL;
> +		else
> +			err = -ENOTEMPTY;
> +		goto out_dput_d2;
> +	}
> +
> +	rd->old_dentry = d1;
> +	rd->new_dentry = d2;
> +	return 0;
> +
> +out_dput_d2:
> +	dput(d2);
> +out_dput_d1:
> +	dput(d1);
> +out_unlock:
> +	unlock_rename(rd->old_parent, rd->new_parent);
> +	return err;
> +}
> +
> +/**
> + * start_renaming - lookup and lock names for rename with permission checking
> + * @rd:           rename data containing parent and flags, and
> + *                for receiving found dentries
> + * @lookup_flags: extra flags to pass to ->lookup (e.g. LOOKUP_REVAL,
> + *                LOOKUP_NO_SYMLINKS etc).
> + * @old_last:     name of object in @rd.old_parent
> + * @new_last:     name of object in @rd.new_parent
> + *
> + * Look up two names and ensure locks are in place for
> + * rename.
> + *
> + * On success the found dentries are stored in @rd.old_dentry,
> + * @rd.new_dentry.  These references and the lock are dropped by
> + * end_renaming().
> + *
> + * The passed in qstrs need not have the hash calculated, and basic
> + * eXecute permission checking is performed against @rd.mnt_idmap.
> + *
> + * Returns: zero or an error.
> + */
> +int start_renaming(struct renamedata *rd, int lookup_flags,
> +		   struct qstr *old_last, struct qstr *new_last)
> +{
> +	int err;
> +
> +	err = lookup_one_common(rd->mnt_idmap, old_last, rd->old_parent);
> +	if (err)
> +		return err;
> +	err = lookup_one_common(rd->mnt_idmap, new_last, rd->new_parent);
> +	if (err)
> +		return err;
> +	return __start_renaming(rd, lookup_flags, old_last, new_last);
> +}
> +EXPORT_SYMBOL(start_renaming);
> +
> +void end_renaming(struct renamedata *rd)
> +{
> +	unlock_rename(rd->old_parent, rd->new_parent);
> +	dput(rd->old_dentry);
> +	dput(rd->new_dentry);
> +}
> +EXPORT_SYMBOL(end_renaming);
> +
>  /**
>   * vfs_prepare_mode - prepare the mode to be used for a new inode
>   * @idmap:	idmap of the mount the inode was found from
> @@ -5504,14 +5627,11 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  		 struct filename *to, unsigned int flags)
>  {
>  	struct renamedata rd;
> -	struct dentry *old_dentry, *new_dentry;
> -	struct dentry *trap;
>  	struct path old_path, new_path;
>  	struct qstr old_last, new_last;
>  	int old_type, new_type;
>  	struct inode *delegated_inode = NULL;
> -	unsigned int lookup_flags = 0, target_flags =
> -		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
> +	unsigned int lookup_flags = 0;
>  	bool should_retry = false;
>  	int error = -EINVAL;
>  
> @@ -5522,11 +5642,6 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  	    (flags & RENAME_EXCHANGE))
>  		goto put_names;
>  
> -	if (flags & RENAME_EXCHANGE)
> -		target_flags = 0;
> -	if (flags & RENAME_NOREPLACE)
> -		target_flags |= LOOKUP_EXCL;
> -
>  retry:
>  	error = filename_parentat(olddfd, from, lookup_flags, &old_path,
>  				  &old_last, &old_type);
> @@ -5556,66 +5671,40 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
>  		goto exit2;
>  
>  retry_deleg:
> -	trap = lock_rename(new_path.dentry, old_path.dentry);
> -	if (IS_ERR(trap)) {
> -		error = PTR_ERR(trap);
> +	rd.old_parent	   = old_path.dentry;
> +	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
> +	rd.new_parent	   = new_path.dentry;
> +	rd.delegated_inode = &delegated_inode;
> +	rd.flags	   = flags;
> +
> +	error = __start_renaming(&rd, lookup_flags, &old_last, &new_last);
> +	if (error)
>  		goto exit_lock_rename;
> -	}
>  
> -	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
> -					  lookup_flags);
> -	error = PTR_ERR(old_dentry);
> -	if (IS_ERR(old_dentry))
> -		goto exit3;
> -	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
> -					  lookup_flags | target_flags);
> -	error = PTR_ERR(new_dentry);
> -	if (IS_ERR(new_dentry))
> -		goto exit4;
>  	if (flags & RENAME_EXCHANGE) {
> -		if (!d_is_dir(new_dentry)) {
> +		if (!d_is_dir(rd.new_dentry)) {
>  			error = -ENOTDIR;
>  			if (new_last.name[new_last.len])
> -				goto exit5;
> +				goto exit_unlock;
>  		}
>  	}
>  	/* unless the source is a directory trailing slashes give -ENOTDIR */
> -	if (!d_is_dir(old_dentry)) {
> +	if (!d_is_dir(rd.old_dentry)) {
>  		error = -ENOTDIR;
>  		if (old_last.name[old_last.len])
> -			goto exit5;
> +			goto exit_unlock;
>  		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
> -			goto exit5;
> -	}
> -	/* source should not be ancestor of target */
> -	error = -EINVAL;
> -	if (old_dentry == trap)
> -		goto exit5;
> -	/* target should not be an ancestor of source */
> -	if (!(flags & RENAME_EXCHANGE))
> -		error = -ENOTEMPTY;
> -	if (new_dentry == trap)
> -		goto exit5;
> +			goto exit_unlock;
> +	}
>  
> -	error = security_path_rename(&old_path, old_dentry,
> -				     &new_path, new_dentry, flags);
> +	error = security_path_rename(&old_path, rd.old_dentry,
> +				     &new_path, rd.new_dentry, flags);
>  	if (error)
> -		goto exit5;
> +		goto exit_unlock;
>  
> -	rd.old_parent	   = old_path.dentry;
> -	rd.old_dentry	   = old_dentry;
> -	rd.mnt_idmap	   = mnt_idmap(old_path.mnt);
> -	rd.new_parent	   = new_path.dentry;
> -	rd.new_dentry	   = new_dentry;
> -	rd.delegated_inode = &delegated_inode;
> -	rd.flags	   = flags;
>  	error = vfs_rename(&rd);
> -exit5:
> -	dput(new_dentry);
> -exit4:
> -	dput(old_dentry);
> -exit3:
> -	unlock_rename(new_path.dentry, old_path.dentry);
> +exit_unlock:
> +	end_renaming(&rd);
>  exit_lock_rename:
>  	if (delegated_inode) {
>  		error = break_deleg_wait(&delegated_inode);
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index cd64ffe12e0b..62109885d4db 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1885,11 +1885,12 @@ __be32
>  nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  			    struct svc_fh *tfhp, char *tname, int tlen)
>  {
> -	struct dentry	*fdentry, *tdentry, *odentry, *ndentry, *trap;
> +	struct dentry	*fdentry, *tdentry;
>  	int		type = S_IFDIR;
> +	struct renamedata rd = {};
>  	__be32		err;
>  	int		host_err;
> -	bool		close_cached = false;
> +	struct dentry	*close_cached;
>  
>  	trace_nfsd_vfs_rename(rqstp, ffhp, tfhp, fname, flen, tname, tlen);
>  
> @@ -1915,15 +1916,22 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  		goto out;
>  
>  retry:
> +	close_cached = NULL;
>  	host_err = fh_want_write(ffhp);
>  	if (host_err) {
>  		err = nfserrno(host_err);
>  		goto out;
>  	}
>  
> -	trap = lock_rename(tdentry, fdentry);
> -	if (IS_ERR(trap)) {
> -		err = nfserr_xdev;
> +	rd.mnt_idmap	= &nop_mnt_idmap;
> +	rd.old_parent	= fdentry;
> +	rd.new_parent	= tdentry;
> +
> +	host_err = start_renaming(&rd, 0, &QSTR_LEN(fname, flen),
> +				  &QSTR_LEN(tname, tlen));
> +
> +	if (host_err) {
> +		err = nfserrno(host_err);
>  		goto out_want_write;
>  	}
>  	err = fh_fill_pre_attrs(ffhp);
> @@ -1933,48 +1941,23 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (err != nfs_ok)
>  		goto out_unlock;
>  
> -	odentry = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), fdentry);
> -	host_err = PTR_ERR(odentry);
> -	if (IS_ERR(odentry))
> -		goto out_nfserr;
> +	type = d_inode(rd.old_dentry)->i_mode & S_IFMT;
> +
> +	if (d_inode(rd.new_dentry))
> +		type = d_inode(rd.new_dentry)->i_mode & S_IFMT;
>  
> -	host_err = -ENOENT;
> -	if (d_really_is_negative(odentry))
> -		goto out_dput_old;
> -	host_err = -EINVAL;
> -	if (odentry == trap)
> -		goto out_dput_old;
> -	type = d_inode(odentry)->i_mode & S_IFMT;
> -
> -	ndentry = lookup_one(&nop_mnt_idmap, &QSTR_LEN(tname, tlen), tdentry);
> -	host_err = PTR_ERR(ndentry);
> -	if (IS_ERR(ndentry))
> -		goto out_dput_old;
> -	if (d_inode(ndentry))
> -		type = d_inode(ndentry)->i_mode & S_IFMT;
> -	host_err = -ENOTEMPTY;
> -	if (ndentry == trap)
> -		goto out_dput_new;
> -
> -	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
> -	    nfsd_has_cached_files(ndentry)) {
> -		close_cached = true;
> -		goto out_dput_old;
> +	if ((rd.new_dentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
> +	    nfsd_has_cached_files(rd.new_dentry)) {
> +		close_cached = dget(rd.new_dentry);
> +		goto out_unlock;
>  	} else {
> -		struct renamedata rd = {
> -			.mnt_idmap	= &nop_mnt_idmap,
> -			.old_parent	= fdentry,
> -			.old_dentry	= odentry,
> -			.new_parent	= tdentry,
> -			.new_dentry	= ndentry,
> -		};
>  		int retries;
>  
>  		for (retries = 1;;) {
>  			host_err = vfs_rename(&rd);
>  			if (host_err != -EAGAIN || !retries--)
>  				break;
> -			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(odentry)))
> +			if (!nfsd_wait_for_delegreturn(rqstp, d_inode(rd.old_dentry)))
>  				break;
>  		}
>  		if (!host_err) {
> @@ -1983,11 +1966,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  				host_err = commit_metadata(ffhp);
>  		}
>  	}
> - out_dput_new:
> -	dput(ndentry);
> - out_dput_old:
> -	dput(odentry);
> - out_nfserr:
>  	if (host_err == -EBUSY) {
>  		/*
>  		 * See RFC 8881 Section 18.26.4 para 1-3: NFSv4 RENAME
> @@ -2006,7 +1984,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  		fh_fill_post_attrs(tfhp);
>  	}
>  out_unlock:
> -	unlock_rename(tdentry, fdentry);
> +	end_renaming(&rd);
>  out_want_write:
>  	fh_drop_write(ffhp);
>  
> @@ -2017,9 +1995,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	 * until this point and then reattempt the whole shebang.
>  	 */
>  	if (close_cached) {
> -		close_cached = false;
> -		nfsd_close_cached_files(ndentry);
> -		dput(ndentry);
> +		nfsd_close_cached_files(close_cached);
> +		dput(close_cached);
>  		goto retry;
>  	}
>  out:
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index c8d0885ee5e0..0f2c2da68433 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -1124,9 +1124,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  	int err;
>  	struct dentry *old_upperdir;
>  	struct dentry *new_upperdir;
> -	struct dentry *olddentry = NULL;
> -	struct dentry *newdentry = NULL;
> -	struct dentry *trap, *de;
> +	struct renamedata rd = {};
>  	bool old_opaque;
>  	bool new_opaque;
>  	bool cleanup_whiteout = false;
> @@ -1136,6 +1134,7 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  	bool new_is_dir = d_is_dir(new);
>  	bool samedir = olddir == newdir;
>  	struct dentry *opaquedir = NULL;
> +	struct dentry *whiteout = NULL;
>  	const struct cred *old_cred = NULL;
>  	struct ovl_fs *ofs = OVL_FS(old->d_sb);
>  	LIST_HEAD(list);
> @@ -1233,29 +1232,21 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  		}
>  	}
>  
> -	trap = lock_rename(new_upperdir, old_upperdir);
> -	if (IS_ERR(trap)) {
> -		err = PTR_ERR(trap);
> -		goto out_revert_creds;
> -	}
> +	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
> +	rd.old_parent = old_upperdir;
> +	rd.new_parent = new_upperdir;
> +	rd.flags = flags;
>  
> -	de = ovl_lookup_upper(ofs, old->d_name.name, old_upperdir,
> -			      old->d_name.len);
> -	err = PTR_ERR(de);
> -	if (IS_ERR(de))
> -		goto out_unlock;
> -	olddentry = de;
> +	err = start_renaming(&rd, 0,
> +			     &QSTR_LEN(old->d_name.name, old->d_name.len),
> +			     &QSTR_LEN(new->d_name.name, new->d_name.len));
>  
> -	err = -ESTALE;
> -	if (!ovl_matches_upper(old, olddentry))
> -		goto out_unlock;
> +	if (err)
> +		goto out_revert_creds;
>  
> -	de = ovl_lookup_upper(ofs, new->d_name.name, new_upperdir,
> -			      new->d_name.len);
> -	err = PTR_ERR(de);
> -	if (IS_ERR(de))
> +	err = -ESTALE;
> +	if (!ovl_matches_upper(old, rd.old_dentry))
>  		goto out_unlock;
> -	newdentry = de;
>  
>  	old_opaque = ovl_dentry_is_opaque(old);
>  	new_opaque = ovl_dentry_is_opaque(new);
> @@ -1263,15 +1254,15 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  	err = -ESTALE;
>  	if (d_inode(new) && ovl_dentry_upper(new)) {
>  		if (opaquedir) {
> -			if (newdentry != opaquedir)
> +			if (rd.new_dentry != opaquedir)
>  				goto out_unlock;
>  		} else {
> -			if (!ovl_matches_upper(new, newdentry))
> +			if (!ovl_matches_upper(new, rd.new_dentry))
>  				goto out_unlock;
>  		}
>  	} else {
> -		if (!d_is_negative(newdentry)) {
> -			if (!new_opaque || !ovl_upper_is_whiteout(ofs, newdentry))
> +		if (!d_is_negative(rd.new_dentry)) {
> +			if (!new_opaque || !ovl_upper_is_whiteout(ofs, rd.new_dentry))
>  				goto out_unlock;
>  		} else {
>  			if (flags & RENAME_EXCHANGE)
> @@ -1279,19 +1270,14 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  		}
>  	}
>  
> -	if (olddentry == trap)
> -		goto out_unlock;
> -	if (newdentry == trap)
> -		goto out_unlock;
> -
> -	if (olddentry->d_inode == newdentry->d_inode)
> +	if (rd.old_dentry->d_inode == rd.new_dentry->d_inode)
>  		goto out_unlock;
>  
>  	err = 0;
>  	if (ovl_type_merge_or_lower(old))
>  		err = ovl_set_redirect(old, samedir);
>  	else if (is_dir && !old_opaque && ovl_type_merge(new->d_parent))
> -		err = ovl_set_opaque_xerr(old, olddentry, -EXDEV);
> +		err = ovl_set_opaque_xerr(old, rd.old_dentry, -EXDEV);
>  	if (err)
>  		goto out_unlock;
>  
> @@ -1299,18 +1285,24 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  		err = ovl_set_redirect(new, samedir);
>  	else if (!overwrite && new_is_dir && !new_opaque &&
>  		 ovl_type_merge(old->d_parent))
> -		err = ovl_set_opaque_xerr(new, newdentry, -EXDEV);
> +		err = ovl_set_opaque_xerr(new, rd.new_dentry, -EXDEV);
>  	if (err)
>  		goto out_unlock;
>  
> -	err = ovl_do_rename(ofs, old_upperdir, olddentry,
> -			    new_upperdir, newdentry, flags);
> -	unlock_rename(new_upperdir, old_upperdir);
> +	err = ovl_do_rename_rd(&rd);
> +
> +	if (!err && cleanup_whiteout)
> +		whiteout = dget(rd.new_dentry);
> +
> +	end_renaming(&rd);
> +
>  	if (err)
>  		goto out_revert_creds;
>  
> -	if (cleanup_whiteout)
> -		ovl_cleanup(ofs, old_upperdir, newdentry);
> +	if (whiteout) {
> +		ovl_cleanup(ofs, old_upperdir, whiteout);
> +		dput(whiteout);
> +	}
>  
>  	if (overwrite && d_inode(new)) {
>  		if (new_is_dir)
> @@ -1336,14 +1328,12 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>  	else
>  		ovl_drop_write(old);
>  out:
> -	dput(newdentry);
> -	dput(olddentry);
>  	dput(opaquedir);
>  	ovl_cache_free(&list);
>  	return err;
>  
>  out_unlock:
> -	unlock_rename(new_upperdir, old_upperdir);
> +	end_renaming(&rd);
>  	goto out_revert_creds;
>  }
>  
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 49ad65f829dc..3cc85a893b5c 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -355,11 +355,24 @@ static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
>  	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
>  }
>  
> +static inline int ovl_do_rename_rd(struct renamedata *rd)
> +{
> +	int err;
> +
> +	pr_debug("rename(%pd2, %pd2, 0x%x)\n", rd->old_dentry, rd->new_dentry,
> +		 rd->flags);
> +	err = vfs_rename(rd);
> +	if (err) {
> +		pr_debug("...rename(%pd2, %pd2, ...) = %i\n",
> +			 rd->old_dentry, rd->new_dentry, err);
> +	}
> +	return err;
> +}
> +
>  static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
>  				struct dentry *olddentry, struct dentry *newdir,
>  				struct dentry *newdentry, unsigned int flags)
>  {
> -	int err;
>  	struct renamedata rd = {
>  		.mnt_idmap	= ovl_upper_mnt_idmap(ofs),
>  		.old_parent	= olddir,
> @@ -369,13 +382,7 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
>  		.flags		= flags,
>  	};
>  
> -	pr_debug("rename(%pd2, %pd2, 0x%x)\n", olddentry, newdentry, flags);
> -	err = vfs_rename(&rd);
> -	if (err) {
> -		pr_debug("...rename(%pd2, %pd2, ...) = %i\n",
> -			 olddentry, newdentry, err);
> -	}
> -	return err;
> +	return ovl_do_rename_rd(&rd);
>  }
>  
>  static inline int ovl_do_whiteout(struct ovl_fs *ofs,
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index e5cff89679df..19c3d8e336d5 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -156,6 +156,9 @@ extern int follow_up(struct path *);
>  extern struct dentry *lock_rename(struct dentry *, struct dentry *);
>  extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
>  extern void unlock_rename(struct dentry *, struct dentry *);
> +int start_renaming(struct renamedata *rd, int lookup_flags,
> +		   struct qstr *old_last, struct qstr *new_last);
> +void end_renaming(struct renamedata *rd);
>  
>  /**
>   * mode_strip_umask - handle vfs umask stripping

For the fs/nfsd/vfs.c hunks:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

