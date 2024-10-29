Return-Path: <linux-fsdevel+bounces-33104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD99B44FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55012838D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B85204017;
	Tue, 29 Oct 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YPADFXd7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cK9ZNYJY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5C1D7994;
	Tue, 29 Oct 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192139; cv=fail; b=lGVsiF8+g63r0TMb7vbSibsXJ6e18MAnhPr2Wj/6l4NzIUbW4aiSoJ4ywJo7ypWvi+UDR0V8PWV7TnPyenGx04g5jNR3Jte+rwF7Vxi19ztcI2Y17seRlHnmSTQRMqK95LP86Q3USLFJoQh43geVplaPi2n9yp52Ps18s1qxQrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192139; c=relaxed/simple;
	bh=m5H7VYFuxi6yjlixjkxt+UmW4T0WFJplNyYz5rSateI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEJCKuZ9qQ4pCbq97n1+JzI6QJyCzq7Skld8ewKJWAxRbxMFQURbyz+Q/ekG012g/KvssJCMR73s2DdmBAVxFQjmVUvAMEQbuXnlhkHIleMZmztkudFFTtZGLbDJOuTtQAFmf9YYMhkj3S2Lptj9UiB+tUCn8ICtChymb4Upwzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YPADFXd7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cK9ZNYJY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T7td77020038;
	Tue, 29 Oct 2024 08:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Lbqt+9YjEpRfTeJn4mDQSD0leJLXT6u91/Afo74OUVs=; b=
	YPADFXd7lIXcOzteK5N/K4KZ7Bow753HxDRYBgoBnHct2d8pXWcD5oeazdzzZuHe
	XFzJ+eJBfwAMhm+uCLypNkxhg8/BAftxzPHa2PQL9BqL/CzY7TcWhdQ0Y0oolEj9
	bLLmIBWItxwC5IvQ9FyIM1qYBXLUocr2G7p29yNOgO9ZVL6d/ES/mpw9dTYrVd7R
	iv+XbGR1tTXJIqa2u1JCCHsEAm7rqVFL2cAccfZyNeNR1Y58jm3nbUCiTjPLGzL0
	hdGowjrd8PMg2KJG1BPFzL4tORw/4/3EQlYS0hnOYkYI7FwSvE3E6MN2roFBiyu/
	QKBsPpu4ETcTO1W7ji0oNw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxmvat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:55:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49T8DMBi034748;
	Tue, 29 Oct 2024 08:54:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnd7c6e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 08:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF5h5/GFiChGtLXFBDfnw+ReXAw1Bzg4OtcfMKucLoGepKeDp5WZPBG9yx4YmOJbSOEKagZIyTFJ/M6ifzJDh1ursC++0UzsgdLKQz38WyarQm1Xg/mqV/MqpT0lGAvA+gJsnFaP2qW0MmQ1UlkIRWyrpFH4sOcln2t4lKx68T4mgS3Z5uKcO+bK+Us/UXGwDz1gjlQQqXevS4Af1bzfYDqufCmlHj6L8XNq3XG1Vnu/kDntF+XvUOuUKMGn6+UAl82oWIzupfpSF6fTT1XmklyyZsBhLYTrR3U/EZaQeddAHdEYTJJFXtJ9wXyYRtoLVZI9SEmGt3/xAS2UxEnA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lbqt+9YjEpRfTeJn4mDQSD0leJLXT6u91/Afo74OUVs=;
 b=tF0oIeO/xx4AaAjt4vW+uuEHJB5GVQyUI61beVGxoOUb+CwHgGWQ5PFQCrsjJF7lW4NBOII2N6pECFbtVNEIh4axU7qBv/n5ee8pDIGhVGV9bkwJ+3GKldgNDO/B6gmmBwN6wno2uTYHRi/co4XBdO2cB78Flhtcc/2JT4iS6F8vAwH+Gu9+sxLH6I+6cjIH30+LRuUrbgu3fnnnSVRl8OHcdtc7aRcIIIpcT8BJIWL2bZbwyyFb5WPisJWbjRxTyiOXwapwWKuykfJBJRtrNrpGIWwjqvZlIMNjEzOfmYTyWUUXpn0c3wcgUkAtpcJEK7ggDlNX7WrcPsOfaofI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbqt+9YjEpRfTeJn4mDQSD0leJLXT6u91/Afo74OUVs=;
 b=cK9ZNYJYW/muu8ywhvL9t6N7EI6JwTqIoEJFjA6iE2KybTAui1VpJLhjsSW3Omue+pDukQKu9Nun+ieV7ge936pkAIiOFnEIBqU+sX1KEIzyKI6puumDkIkYE2oZBQzAbOQKthU5g2IDY+l3RSJGldVn3PhRK+VvJ8wPRcnoXuA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB5918.namprd10.prod.outlook.com (2603:10b6:8:ab::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 08:54:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 08:54:57 +0000
Message-ID: <39b6d2b2-77fd-4087-a495-c36d33b8c9d0@oracle.com>
Date: Tue, 29 Oct 2024 08:54:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ext4: Add statx support for atomic writes
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig
 <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1729944406.git.ritesh.list@gmail.com>
 <b61c4a50b4e3b97c4261eb45ea3a24057f54d61a.1729944406.git.ritesh.list@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b61c4a50b4e3b97c4261eb45ea3a24057f54d61a.1729944406.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0006.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a589c17-f396-47af-5e31-08dcf7f75d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tjc1SXJUeXF1MVJ2OENkZWxCcmhKL0x3TUpRNGtxVHNLcVhBVnp5MU9SYi9r?=
 =?utf-8?B?U2xnQm9YL3ZDaGxQVGdORFd0KzJadnFMMlRjRVZyOXZLbG1PMmNGSTQvL1NQ?=
 =?utf-8?B?L1NkZnQvY3B2bTlodEVDb25NSG1JUWJBd3FoS0YyNXJ4aDJiN0w3QjF2S1N5?=
 =?utf-8?B?OXRMcDcrakl3ZE0rUG1GZkhBWmNoMmk5K0I3bkNveHRKQmxGZ2I3UjRIQ1VB?=
 =?utf-8?B?UkNHY29OMUtSQnNxRXZvbnlMN2hNOWU4QkRPa2toZyt1ajlXWTNhMjFIdVFj?=
 =?utf-8?B?dGlrakJzWWUva1NBOWUrcmZITFROckN5eS9PRlVib2R3RkE4YnZMUXhiQUdy?=
 =?utf-8?B?c05TSkVIcURsWjMrdG50YVN3OTFidmpvQ2tzQVdJVS9XTEROK3BUUVpvYlc1?=
 =?utf-8?B?cGR6NG9tL0hjOWhqaXFvWkQrcVR1OUJCUFJMaXZBTEh1eUNqcDV6SklzRDRZ?=
 =?utf-8?B?OTFnY1ladi9DbUtCVFY0MWF2R2FWUmJLeTJoR0tlZ1Z5dE42bmUrcHd1NG15?=
 =?utf-8?B?YU55c2phYzg4bzBBb1VVc3I3K01pNW5CNU0zclBHNGZ2cEVJZ0ltQkhOTzdj?=
 =?utf-8?B?V1B4Rml5VlRQUE9FRzY4V0lldjdNNTdLbzBkZ1RKL0pxSnZwZDhxV296RHZF?=
 =?utf-8?B?QlhoU2NtMTZDK0VGRjJxdnBwOWVIVEtLdldYRnVBSko5U2ZDTWY0bzY4NXZv?=
 =?utf-8?B?bUc2ZWt0WGpGNDkwUGNrUy80NGRIQUxQeURFMFR6R0VCMDdMa0paVEdncENH?=
 =?utf-8?B?U1pNemNVTnd3bXJoNlFweXFYeGRzbVQzTWR4UEd3VjY1ZU1Qdk44bXMxQWVs?=
 =?utf-8?B?eWJld1p0NHhyTjhwU1dFUWYyYWhaTHYwdW10MWR0YU1tMFF2eGV0UkVQVCtF?=
 =?utf-8?B?VjUzQUhyR1pOM2hJYnppT3hac2dBNUtMSnkyWWpYKzNWck1qS1ByUkRNMDlR?=
 =?utf-8?B?WFZpTVd4MC9ldko3ZWtnVWNBbW12L2VyNldXdUs4TEFYQkVtNTFsSFh1VUVB?=
 =?utf-8?B?UWVYUzhRakZ5eDEwcG8rTW9GQlJ5QXY1MnpiOXRhYTVSSE5qaGp4RW1SalRZ?=
 =?utf-8?B?RzFRSW8rZFA4bzk2d0ZCY1hIZHQyaVRpN3FrSXNING5kVHVQMDVKR3dMTGlx?=
 =?utf-8?B?OC9rd3p3WGFHbUhPTWpLZ0JKUUhQSStZNjFHaERzdkF5WWVwcEl5bEtwRTB1?=
 =?utf-8?B?V2k4S2VXTDJ2b21XelBMaFcyR3lMUm1JVTNwL1NxVmREckZBb0NjbGsxaXZt?=
 =?utf-8?B?RVdLZThHYWdwMGhWR1N5cC80UkZveW0xZjVzdlRHUHdwaHdrc3M1c3RFY2FH?=
 =?utf-8?B?OTVNbGpDZUFoNU1VdDVEOTdZa0wvaTQ3S1Z6d2hYQjlCWWpROFZrN1BpZWo0?=
 =?utf-8?B?OVhhMlN3UTJtbjdpVzhMYmx4QjI3ME1XQys5OXVFL0ZkZ3ZEclBMamF1OWdQ?=
 =?utf-8?B?LzV2NGUzZU1mdFNOOHpSbkxnYnlJWXZZTWlpT3RLM3dGaHFBQncyZkVhTnY2?=
 =?utf-8?B?dVN2dFRsQVZGak9tSTV0L1VueHBqLzdFWWs3UmpkZk9xb0QrQi9reklJN2tO?=
 =?utf-8?B?N1k4NXRkaForU3ZPVWE2QnhFNlFtWFBnOXVwdzBFcjRMMWJyYUNyRTFMVjNY?=
 =?utf-8?B?VTlKZ01Od1J2OVVhNEIwRklRblBRNk1WS3h4eVlJcWJZdjY3bTVWSy90WmlY?=
 =?utf-8?B?TG5oeDNBazNVRVZQM1V6Y1lZekpuZEUxK1lBd0JkNVRTL1UrQ3o2NzgyWStK?=
 =?utf-8?Q?rPO4YMhHZM++w6GhnM7374XxkjeTXKIsuPZXL/8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clpybU1YY3BobExBVHo1RVNVa0hvVW4rTm8yN044MzZTSmZuSU5GU29SZG5p?=
 =?utf-8?B?MWtBODRrQ3NxTGNuWE84Y1lVbS9nM1VQNWd6QjlHU2M1UkhENzRHbnFpRjhZ?=
 =?utf-8?B?eW5BdndGVEhyWG04K3RFeklYK3JyNlM5MnJEZGVnbnpZREd6ZE91bDcxMDRq?=
 =?utf-8?B?UnMrcUU2QXJ1V0w1RGNOdWJUY3VIUnJFSGhSbkpXYXlrU1dRWEMzZWFyR2Qx?=
 =?utf-8?B?U3NXdWlXL0UycnJ3aWJjMGFCNnNEdVY2M2Vrd0xlOUlDV1BJb3k5UDUwYVYr?=
 =?utf-8?B?STF1MzJtQ1VMazVNK0E2dG82Z0N6S29yRmJteE1kVC9VT1g2MzZ5a1FNMW5L?=
 =?utf-8?B?d0ZBKzlpSGJZMlVueFlpKytvVHNjNHIzSDFJWHVCZDJKLzR4Vm5XbGl1dG14?=
 =?utf-8?B?RlNweG4xVFNwb3RNWlBhNTBHWVdyR2tyeFl4M1FUMXlBb1hBdVlsaVE3c2pK?=
 =?utf-8?B?cUdxVVVKZ01lc1UyQ0t4YzA4TUZ4WlM4NkpUT2dMczlPQ2dqWXZsalRDUVJz?=
 =?utf-8?B?NTRHSWdwdG1LMDBLbEtVVVBwUm91eGFUOEx6THNZQVVuSEdQTEFCaDFWRjRF?=
 =?utf-8?B?SmVRMmhjZU82TVcvR25zS1hzV0x2QzhTSDVyTU9mYkxmUzFQNGF4cENCcFg4?=
 =?utf-8?B?L1U5dklDako0SEVnQWU5eFFLcUN4OFJzRUtaUkRDMy9JRE5UaVh5Vzg3dVRm?=
 =?utf-8?B?SUN3K0lDREpzQVlxc091MkV3YmViRHplaEdWU0p3TnEzM0E0aE1MVFZvQS9t?=
 =?utf-8?B?VlMyOTZUNDlMVElIWDhZMWJvQ1I1eUg5a1BsUFRDQVhjcE1sczBJQm8yaWZW?=
 =?utf-8?B?dWEzeVVCTkhZTnU5UCtCaGd3dVQyVWNpZzR0MXlxNThTT2tsTGlXdGF3TzFN?=
 =?utf-8?B?Lzl1K3NtSnFuakcrQW1zazF1aWluek0wMHdGU1NmVTJOWFdWU0VMZ1FaYWlk?=
 =?utf-8?B?ejFIZ3Fia2luR1pxM3FCU01JeFRsdmVES2MvV1Y4c21qYjNlakV4VFlocUFp?=
 =?utf-8?B?UjZvQms3QmE5Z25EaldKaE94SldHZnhFYlBCRHRtQmxrT3hmZnh5SGxBcGNk?=
 =?utf-8?B?VjJDOFBGcUFlVzZiY1RhdFJ0dHBibU54T2VmSDc5UE1acnQrNFBqLytCbFpY?=
 =?utf-8?B?Z20xVkZsZTFUZE1iNlZkUFJTSlZpOXE3WnBVY0txVXpMbjVWWDVjdWp4aFVy?=
 =?utf-8?B?NlFrbFVhREtYaG9GMHl3UXFCbTJOOVdoc3l4RzlQZkFyTDNkUVN3MDZzUGZz?=
 =?utf-8?B?UzR3cHYyV3h3RVEzd1NoTUhJbGNmNDgvL3NRUVZPTUlwWlJGRUg0ZjFaSTBn?=
 =?utf-8?B?MEduMlVXQ0VRNzNrZXlqc2pUV21uUkJ2aE1Bc3ZwYkFXMy9hell2MGp6K090?=
 =?utf-8?B?bnF4WlluU09Md3VXY0l2YndBd1dDMm05c2R3Y3VraVk2aitLNllLQ0E0MW9p?=
 =?utf-8?B?OTNlMzBPUnlsdXR1L2ZvMDBxbHI1L2xMQjd4NjlHMlIyTG1TWmQzbUFrYXo0?=
 =?utf-8?B?VGVCUGRKRldpY2NCWklLbTVuQkRxQmkwYlB2dXFLa0wvOGpqNEZSTVJ3ZVZU?=
 =?utf-8?B?NDE5MlJyZjJJNXNrTm93Wk1HZmhBVmwxSHdlU2o1Mm82bTJseUhVWmpnaXBP?=
 =?utf-8?B?dThYVGNkayt0MFFMdiszTzV5bXJDOVFnWXV6cHpFc1JkWWpjV3p2dExrbzJC?=
 =?utf-8?B?SUVQMm9mbllwdnB4azFiek5aTkZ5NG85cnRXYWpWblc2K1kwY2I0aU5DQ0x4?=
 =?utf-8?B?L0toY3ZIMHJxWDl0STc5Z1k4b2NzNXlMMy9IWGVEVDcxWnpYN1A3WC9vbHZn?=
 =?utf-8?B?dFN2NDNyQ3doVGYrTnlQN3I3alFEYkpBRmlzSUJ0V05iNnhOaHFMQzd4VUp6?=
 =?utf-8?B?SGk5MENvSDl5NVdZOU9vQUx6SzdNZ2k3MkpjZWtPRnJIR0lSL3pwTy8zbGwx?=
 =?utf-8?B?bzloZEVWMzJmN0FFeXQyWFFGRjBTSHNINnM0ZzJXOS9lTHZITjlldDY2dFll?=
 =?utf-8?B?YjkwMk1iTUpEWDg5NDR5N0dQOVk3eTVUNjliSWpUTy9selRNMVFwQTRiTFBq?=
 =?utf-8?B?bXE3bWFVdXJla2kzVGY2aWE4NDc0dTJJNndDOG04dDFLQ0JkRkdTYnVaSHZM?=
 =?utf-8?B?T2RtUmJpbTI0MkxCdEFLcURGWkxpRlQ4NXRneFc0L3hBY0FxT2ZKWnE2dzlW?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mICbwQiPUNbyT99YM4IPEXv7Lu/YjIrd3BowXNWqlT5eOtY0/jQ71ozwH0P4WcAsWngw4Cldq0IEKGJVguoEgQU/fHt6YOTafagVO3XIRODChb3EjXfiL9k9eS6mF2CRg1Ww8r+4u8iidf7EJggiib4vf7qa+b2bR0oWzeyiib2iroGM5GwK/2owwss/wvV5bMm6mMWqPtOBC6yYdlEEwXFsLwa0V1t2nV8l2laUmhC41apDvwtVVfXTuncOco7snaeG+/cXeaaoPILcEdZQoJBG0KOGTY/nWl0X407nIkcnilT23+YaDNT2CJlrZG3PGU8175fAH66jmLK3kwsDKWrTay/GJk/c4bGc8duFE4XuNrtG+ObUesFbcJ/Vm5OIPo0+nYVLIzEMQl1318JogoD9jy1LaIf3QhSXGd/ZmKJrNHpwHSqU6Kg10Y7HqoOL+2ce2XLbeRWjysSlGebI6KJSqZqiPEvKxUuQAl5kowuNYxOXY6cNcrB3lO3wIYcdj4EFo1Uel2r4pfv5uTH7FHdOt8z3sP/TnjssJDcX6gzmNAYW1y39444oOHDphe8ShjqbTd+bdWacjsY5+slmPdTdDAJOHvLEVuWoKb3JmCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a589c17-f396-47af-5e31-08dcf7f75d62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:54:57.7624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HT8OSi55OLLbNLs51k7oyKJAcI1mVaR9WLe/u6SPYJ6yTkKJJCaj06JGdcBj9QXgytvv+5XHpw1/eoN1Qg4euw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290069
X-Proofpoint-GUID: WIDlQehOWG98qwTmbm4rJl1ydM7gfyWE
X-Proofpoint-ORIG-GUID: WIDlQehOWG98qwTmbm4rJl1ydM7gfyWE

On 27/10/2024 18:17, Ritesh Harjani (IBM) wrote:
> This patch adds base support for atomic writes via statx getattr.
> On bs < ps systems, we can create FS with say bs of 16k. That means
> both atomic write min and max unit can be set to 16k for supporting
> atomic writes.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   fs/ext4/ext4.h  |  9 +++++++++
>   fs/ext4/inode.c | 14 ++++++++++++++
>   fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
>   3 files changed, 54 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 44b0d418143c..6ee49aaacd2b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1729,6 +1729,10 @@ struct ext4_sb_info {
>   	 */
>   	struct work_struct s_sb_upd_work;
>   
> +	/* Atomic write unit values in bytes */
> +	unsigned int s_awu_min;
> +	unsigned int s_awu_max;
> +
>   	/* Ext4 fast commit sub transaction ID */
>   	atomic_t s_fc_subtid;
>   
> @@ -3855,6 +3859,11 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>   	return buffer_uptodate(bh);
>   }
>   
> +static inline bool ext4_can_atomic_write(struct super_block *sb)
> +{
> +	return EXT4_SB(sb)->s_awu_min > 0;
> +}
> +
>   extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>   				  loff_t pos, unsigned len,
>   				  get_block_t *get_block);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 54bdd4884fe6..fcdee27b9aa2 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5578,6 +5578,20 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
>   		}
>   	}
>   
> +	if (S_ISREG(inode->i_mode) && (request_mask & STATX_WRITE_ATOMIC)) {
> +		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +		unsigned int awu_min, awu_max;
> +
> +		if (ext4_can_atomic_write(inode->i_sb)) {
> +			awu_min = sbi->s_awu_min;
> +			awu_max = sbi->s_awu_max;
> +		} else {
> +			awu_min = awu_max = 0;
> +		}
> +
> +		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
> +	}
> +
>   	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
>   	if (flags & EXT4_APPEND_FL)
>   		stat->attributes |= STATX_ATTR_APPEND;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 16a4ce704460..d6e3201a48be 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
>   	return 0;
>   }
>   
> +/*
> + * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
> + * @sb: super block
> + * TODO: Later add support for bigalloc
> + */
> +static void ext4_atomic_write_init(struct super_block *sb)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct block_device *bdev = sb->s_bdev;
> +
> +	if (!bdev_can_atomic_write(bdev))

this check is duplicated, since bdev_atomic_write_unit_{min, 
max}_bytes() has this check

> +		return;
> +
> +	if (!ext4_has_feature_extents(sb))
> +		return;
> +
> +	sbi->s_awu_min = max(sb->s_blocksize,
> +			      bdev_atomic_write_unit_min_bytes(bdev));
> +	sbi->s_awu_max = min(sb->s_blocksize,
> +			      bdev_atomic_write_unit_max_bytes(bdev));
> +	if (sbi->s_awu_min && sbi->s_awu_max &&
> +	    sbi->s_awu_min <= sbi->s_awu_max) {

This looks a bit complicated. I would just follow the XFS example and 
ensure bdev_atomic_write_unit_min_bytes() <=  sb->s_blocksize <= 
bdev_atomic_write_unit_max_bytes() [which you are doing, but in a 
complicated way]

> +		ext4_msg(sb, KERN_NOTICE, "Supports atomic writes awu_min: %u, awu_max: %u",
> +			 sbi->s_awu_min, sbi->s_awu_max);
> +	} else {
> +		sbi->s_awu_min = 0;
> +		sbi->s_awu_max = 0;
> +	}
> +}
> +
>   static void ext4_fast_commit_init(struct super_block *sb)
>   {
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
> @@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>   
>   	spin_lock_init(&sbi->s_bdev_wb_lock);
>   
> +	ext4_atomic_write_init(sb);
>   	ext4_fast_commit_init(sb);
>   
>   	sb->s_root = NULL;


