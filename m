Return-Path: <linux-fsdevel+bounces-28758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011396DEB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF371C23365
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E719D8A3;
	Thu,  5 Sep 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SGJ6/6/8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MLlHox5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC5101DE;
	Thu,  5 Sep 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551128; cv=fail; b=d3CY7tK06EgvPlDGTPJX8U3Ge5QELxh8yqONIxyXkSKk3AMAciC1KhOXB0dYW7MZCifvz4HGVVi+q7sU0sKzMu0tJ2gssukCMAr5YvNLU9x7hlj94oQBCcW8QNI8fm+HFcuSX8rNfvPnMi4u9PQNapGWd2Jdh7j99sjaAbvOZwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551128; c=relaxed/simple;
	bh=uG6x0tk+6GIwMIaDnSwyR65fv+GkRIl6mjHN+FiKHfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N/rLs9RQIe0vG8P3Bfm7gJRSGSzTsZ1qKLRFP4dQoElC3zifb/TYnBJaMiHotjvTgMJzRO0smIfdypsFaaH1V8LxLBZEIfRtQJ9RxDVYNhaSpBtQMeqO3GIPPxdbOdk3GwGCEVrdARNX85qpdxEdMz7J3AwQ7/SO2s+2x7KI/lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SGJ6/6/8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MLlHox5k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485EtWod031730;
	Thu, 5 Sep 2024 15:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=8LITyOXAbycoHNP
	U1anm2HDYha0rYZGoB0zsvSWq+Ts=; b=SGJ6/6/8nudZvw5nHmPMQU8fZ0BqSmn
	QgU3B3XEaJrs95MdOT3VUWhrl++KGYTsTrbpmC8M0PCHDnZuHC4VhqbgA/MGqUGL
	RGVwyynH5JkYpKTMsHcqIYRheNorsL+aGrfla4elG24OdGBAAkGvl0KjLBiw/Tl4
	SDDIsquGZiJiXmoBLVzpwpdqBXOOeeDGjzapforuV7UEcef4MXTTxyYJ+xZqc7i1
	TDhFaAgU3zj0ISaVmE5h7Gx0MkSnvXbsyaFXZxJbJYu7s0pkLZ0IU1bwGvPyVN0X
	KE2lKfBxPtybMVvviwnLY5lGQ2GmidIRVeNgrSDcVDzQNtl6hU6JGgw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dvu7e5tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 15:45:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 485FRT9R001737;
	Thu, 5 Sep 2024 15:44:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmhy2f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 15:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz+4pc7CAX573x6V67E84z4KlIvZ8p/MnFUeLl2i0gF59w/Y0zLe9pbSrj3TTfSBUCKVIYNnvKNhluliWSRH81QsvIFlKEWQPYWpdy8jhk+7qW9FXl46/Iy9dAcHui1Ucb7lsiVRhpkq949mDBp5pqQdodZMqfPxmw0hcic/j8Uf/UMLxVsrrCe1rImvP2cBslRj92qKgmgN4U/Tk6weQfaa3/HLzyeeqvBtRnRAg+6+4TL4tCcgYvQn3c/FK+M6nTzjTkfQtQbaUaGI+ErCOI8eJQZ4iN41zp6BRDg9Ovp9V7V5O8qR8kMz43qbOy79Ta2vYl68jVhd9IReFTbu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LITyOXAbycoHNPU1anm2HDYha0rYZGoB0zsvSWq+Ts=;
 b=lisXOzNTGxdybjGVlAbrvarIuANfleR9Gbj9RgolYGh+AjPBC6c/xuYJYYLXAVcoMTtw8GgHR17S0Tgc/no+MPvfcHHVZUEDoA+HIx2r6CsHEV7egi5ZOx+a/r+fcISSBauOOEFpOJBGCVD8BxrzL0P0nbLG6SuuejMU/1/hJhKmq19WdoUWotWdB0f1QKiVC9CY9YrIJq6O/UuIFQCIhQb8X/ET4z/UrRfauQN0VOsII+xLbJ7SaoConzsrS24vZWUFu2sxQQ4kVpnPLTn/Qj2MwgicDTp6/ugMuT11CKvdheBydvBo/wRz0v9tqIwWpts3Vq09Qywfm4mp+mq/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LITyOXAbycoHNPU1anm2HDYha0rYZGoB0zsvSWq+Ts=;
 b=MLlHox5khbDlfyC2urM5wuuooHqT/fdHQ1ncCtCVV8oxhJf2XSieIeh58M24ZNS7akNeTZCRGQLJKxdfJoNz5om2T/ouE8suxXlQ+ToeC4BYhBcQEjxtPTFJoIWR2PnUf+baWfqaI8wZKy6zDzibwR/9Ej+fhTv+u8K/3GfTaEc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4243.namprd10.prod.outlook.com (2603:10b6:a03:210::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 15:44:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 15:44:51 +0000
Date: Thu, 5 Sep 2024 11:44:47 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] fs: handle delegated timestamps in
 setattr_copy_mgtime
Message-ID: <ZtnR7x6pYz1x7LvK@tissot.1015granger.net>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
 <20240905-delstid-v4-9-d3e5fd34d107@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905-delstid-v4-9-d3e5fd34d107@kernel.org>
X-ClientProxiedBy: CH5PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b7c191-6025-4726-1e01-08dccdc1adeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5bjShqZxRUWthwYOkgDHwgqpaPJlWNlAY8ZlZZeUPNH1Pqz7m2Y9MgHV+wry?=
 =?us-ascii?Q?3ztPgvR0CunlqBueVnYBPlTP2qJSDghb2dOfis0PMmVKBrziEH/vh/oXTaft?=
 =?us-ascii?Q?J4RJpCaFSjgskvjJcKDcIciSb0pHOFjfuHtRtCCgMzPoCybdnGryy7vmElhV?=
 =?us-ascii?Q?V+IvR2dGQQela2N38w6yof1PcSlgkDBfZ82wXkt6HW2hNNA/9p9yVG+YlpOH?=
 =?us-ascii?Q?lZvMaK1DO5kZlXFnJoLaS0I18lIKrLfP1sZ4VL6Cwcwzf9PqFtbxplzXqePh?=
 =?us-ascii?Q?G6/r+Jt40umVtOHRotm+p7wHy7qfT0zdGZmPcTp4BSczRn9rI2CviAP//5tN?=
 =?us-ascii?Q?pLQ41w3+jH3mGM1eaACvskemXqJhJqp2tsTCw4oykhPfKifJPm2iVSCoeQvt?=
 =?us-ascii?Q?l5YCnPhcS/FhR4FHvp/1Xn48AQ4MnT8bZM4gu7fGKSpeaLJKLyQGlgSA+deB?=
 =?us-ascii?Q?VMu69bJxGiNbZs+wDss5aY26n+Og0pZeufvmODK+AoH5AYCgH6pTgQtI8HcA?=
 =?us-ascii?Q?QBhwrustCxeydB10nbJibee9ozRIEaybXOWVscMIKbfZWNlwxD/AOjziaP+2?=
 =?us-ascii?Q?LORmvpgKoTdxfsV4s4JDYlaq2Egw4/x6r89WONQvKBD7Ls4zqNOQv40/Uiqw?=
 =?us-ascii?Q?vuRwwAZo8eaoGabVxgWzSmsbPQ/aeSikC4ltsYyuL52/2BXbU6c7QKWT7xOu?=
 =?us-ascii?Q?T7BzkKV/YaQgQRX3qodVxz5SvMANHI2jMpTKJxXrl+BHcJVMJODnyadkaqz9?=
 =?us-ascii?Q?KjFM47gDZFY0sLijU5pAr+WKOY0Th1ZFKRnF/hSoaRxqGiKGqWhO9/u9CDHy?=
 =?us-ascii?Q?e4KIIefnwNToENSGWUxqflgCf6NiQJgVAzK+sKaUHD7SK+zcQifZEmxVKn1p?=
 =?us-ascii?Q?WlBUeTuqytwEberIlzlyKA4ArunaoJXvlxtQ1dLLvu31qr7i7BHNCwsIpTgi?=
 =?us-ascii?Q?IJSe309T+7tsr3ELzh3HK2Lk8fSHF2HX9StR2Jt09AUveUZc0Mf3/mhLE7Z/?=
 =?us-ascii?Q?/ss6v+Bigwldvr6qv+qToO1iOeqDObsmFIofSJjwjD8HnFu+WWgsHH1GJhTB?=
 =?us-ascii?Q?WqpSqKYxKFTfOtDltN5DqP9gocDcWUWEp3rqJctDvyZ7HBqdVhuT96CFg7zb?=
 =?us-ascii?Q?e8gwotAXNDHXxW41sGqkLw05fRWvidvSDe+nLepCvlLuWB1SubtRHB5jHRxy?=
 =?us-ascii?Q?DLdrnJvNsZcdKYuEy7OMVQujShQQfLyvCq+S0aJ+NsWAUGl1BHqUgur194Kf?=
 =?us-ascii?Q?HDzgumxyKl8DAVvY7bwvXe4OpLNAKifpHZ/uxqT9I6d8qFrEHzj/jPMntqHk?=
 =?us-ascii?Q?7QyRZaZyb2DFNuAGYZYdP8LWp8lSy3KI/XAtUHYUAcM/Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yH9QnBkEFLvz3HbRNVk+IL9/44fVXe6Uys7C46qufZQpFOqwxTpUR+xn4NOi?=
 =?us-ascii?Q?MJkEH7mAxGfQ2oS1AzbtBj6pkz265JCjjz4HVbJQB8PcTBnk8RrNkPdcCC6S?=
 =?us-ascii?Q?PDpLjCS6DzdwJmbtiS7450fa2Ay3HvWS+a3T2Vj78Slgp8xz2ceR2450jMsd?=
 =?us-ascii?Q?EM8c+Wbp7icEeYQAyymuoHry4T8QxvPEPWq4rzkFJgKvlb/GBJWtxULSgHx/?=
 =?us-ascii?Q?1LX9fiJplefoMcyE6se3VqHxaaqOTWF+SiF99XzItYrea6gboDWpXDKzoCSf?=
 =?us-ascii?Q?E+mSZD8A+hITJwGqbLhqAAOFQUhMZe806PiqS3cwzYrExLBloqoL+cTkdBIL?=
 =?us-ascii?Q?zh7nCKg6DppbQx7Ee0SCjRPXlG0gIkmevrnu9A6pz1HLbiokWqTaP375djWK?=
 =?us-ascii?Q?JgTvixk3ZcOyumj+jOPt0QZ57WjOISKvN0PdYlGP6sgCCh9xu6VElr5K6hgM?=
 =?us-ascii?Q?FyoPMDbZbsR6KwYj17F4Hm0eSKUciwE2whSbLmVBBtOiiZE7YLUPuz9sqBgU?=
 =?us-ascii?Q?82eJ50fgZCD4T+OUSk0O47121Bj0WSMY2Cx8vhaWewP8ag2BFu/GDE5rqiww?=
 =?us-ascii?Q?BGAJDuisnn/oJ1qj9+8iM61Rt7Ve4u+d1XL8Of3vFq6Iv+40JU+ZBb31RqSd?=
 =?us-ascii?Q?Zyci+3vW2TayKaoTL3Rrv4dXk/wiYemYS6XIzHymbI4gVfEYWUVGfA5ozM1q?=
 =?us-ascii?Q?f34jWbCsVqi4PEcTVJvvd/5vyLuogZvDlSj+5Xpc6C9/3GzZNGmnXrvONFJR?=
 =?us-ascii?Q?L+ZgvX0aAcz3xCLaeo2YPwe25g7SmfqUhioPZfycnvxqxc6PaSWsBJqtu4qy?=
 =?us-ascii?Q?nKmt0fDk+0Q+sTGjsoV7U50Tb2Q983y+fwQjKk9AmFm/7nZ5ejj2fY0WaCC9?=
 =?us-ascii?Q?5k+qK66hzzJN/oSAs8336v9SbebjBmZSYTJG1+TOzNxLT9ac27sQ6tsIbh5P?=
 =?us-ascii?Q?nRma+b6ic2ZYPpnEyyM19mRNOy35yRJE0i8oAvs05MNxZPTBbS9M4YmQ/dot?=
 =?us-ascii?Q?j2Y/nbBCrFF58rQ0lr+yLeB0zCNj7zC6FNwg2vc8LrC8umjBTu6zMdvAX2Zu?=
 =?us-ascii?Q?+qNNHCZsXw40cwootEHGnmkgvWY6PzCVEEjgbRaBGUTz5qpAO9SlSCpSjIW+?=
 =?us-ascii?Q?40MFg7rXkZwC0GWdt+ez/jC0HSpsm/pMwlli5+b+cYTLg06d2U/F4FQesu0W?=
 =?us-ascii?Q?PT7Bq0DQBUchx8dOkVLTqCLb4hj44NtyE8olFW610s7s24BegPHCB9x6An/p?=
 =?us-ascii?Q?p/Y2Ym/JpBpFZviYO958caq220U/INvy9cy/MQyx5V6JY37ysvvNAWH+E2RL?=
 =?us-ascii?Q?DaSD63EYtv+gmGR91LFj3TqtJ9lOwWEm26pm1cnCSylEqNcjvQEEojgKh3Ky?=
 =?us-ascii?Q?MWVBxnU9WqnR0e1HHvtJUqLrEfMMLEPksUIJH0TAUPhOjTuUVMIn3QpsYwqm?=
 =?us-ascii?Q?OVy7sbK6l/18US6krd0z0XcNLdZr+QmXDSbA/2jQyC1l5i7Hg4XpCAQFGqYw?=
 =?us-ascii?Q?o/n4c0DobW56/VpTPWQByQIIZDELKUhIUf0iJVUVJgvsGJV8oZleiuWIRSUU?=
 =?us-ascii?Q?ulwi9IothK3sYzRtPpI68n3LT5JJdhC/Jlppc+yNJ7y8+mvxk7OFWgNramWs?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1paerz/rZqkjfiu1kij7ERH3NEL+OzpSfFTnbo4V7SwvnEIZad4TW7aGWGD3ZMpkzGzSlYETE0HFhJDFaHrQxOwFjO0Ank0n58s3sjbRO2Rn5QoPOucu71VQ7sI3c+Ez91y8dxmjFDyDDOnQwl7vqGIQxUvS6iXsJRk5Arm+ldjCPmSqpGkZl8TcDe18Hb03XzDv/S/nNySTUWVomsselq6raXZgC9ck0TTh9f+VTwcRAtcocnTpOuo532jyfIAiw2X1UmBYDpcG/PPWTGrWolh1l3YCpx5Mq8N1pXGJc05q5mf0JLSm0LUgOMb+FbiXTG8lkdLf407L+utMFnyGqu2A7jnWJCcd4U+6v+ph7ILPzYh9BL+AbFIwOh4e5Knl4itmYxFKcOOMdwebsWJ6y9ub4jidJ9wPNlbRor7EjLm3YL55FeKWdWZel/RoEpm0QH0/Pg8amguK2pKO8sQoHMgGo9twou5bQivn46EsGXlWb8fwPiqSPh5qDEEY1JabcDpvpvIQwB6iyanx66HaXyjHq5DLk2l/RmxZnlAUF+kicegSBnwXVNZ6i4fy0h9oNgGhLRSLu1H25V53gqDfY5mLsjRQgcIkNB7zTmJ+HMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b7c191-6025-4726-1e01-08dccdc1adeb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:44:51.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd5tdF7Oj8AN4jjpWT3k21KzzKufQUYuqVVSbxASoC+mBtK4g0Y/dMNi9Yzgcskl7gxQg57ZX/JzTjrVXmIRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_10,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409050116
X-Proofpoint-ORIG-GUID: QAcsNukFIijBXzm8xBxp3CwjuFtrbu8I
X-Proofpoint-GUID: QAcsNukFIijBXzm8xBxp3CwjuFtrbu8I

On Thu, Sep 05, 2024 at 08:41:53AM -0400, Jeff Layton wrote:
> When updating the ctime on an inode for a SETATTR with a multigrain
> filesystem, we usually want to take the latest time we can get for the
> ctime. The exception to this rule is when there is a nfsd write
> delegation and the server is proxying timestamps from the client.
> 
> When nfsd gets a CB_GETATTR response, we want to update the timestamp
> value in the inode to the values that the client is tracking. The client
> doesn't send a ctime value (since that's always determined by the
> exported filesystem), but it can send a mtime value. In the case where
> it does, then we may need to update the ctime to a value commensurate
> with that instead of the current time.
> 
> If ATTR_DELEG is set, then use ia_ctime value instead of setting the
> timestamp to the current time.
> 
> With the addition of delegated timestamps we can also receive a request
> to update only the atime, but we may not need to set the ctime. Trust
> the ATTR_CTIME flag in the update and only update the ctime when it's
> set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/attr.c          | 28 +++++++++++++--------
>  fs/inode.c         | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  3 files changed, 94 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index 3bcbc45708a3..392eb62aa609 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -286,16 +286,20 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
>  	unsigned int ia_valid = attr->ia_valid;
>  	struct timespec64 now;
>  
> -	/*
> -	 * If the ctime isn't being updated then nothing else should be
> -	 * either.
> -	 */
> -	if (!(ia_valid & ATTR_CTIME)) {
> -		WARN_ON_ONCE(ia_valid & (ATTR_ATIME|ATTR_MTIME));
> -		return;
> +	if (ia_valid & ATTR_CTIME) {
> +		/*
> +		 * In the case of an update for a write delegation, we must respect
> +		 * the value in ia_ctime and not use the current time.
> +		 */
> +		if (ia_valid & ATTR_DELEG)
> +			now = inode_set_ctime_deleg(inode, attr->ia_ctime);
> +		else
> +			now = inode_set_ctime_current(inode);
> +	} else {
> +		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
> +		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
>  	}
>  
> -	now = inode_set_ctime_current(inode);
>  	if (ia_valid & ATTR_ATIME_SET)
>  		inode_set_atime_to_ts(inode, attr->ia_atime);
>  	else if (ia_valid & ATTR_ATIME)
> @@ -354,8 +358,12 @@ void setattr_copy(struct mnt_idmap *idmap, struct inode *inode,
>  		inode_set_atime_to_ts(inode, attr->ia_atime);
>  	if (ia_valid & ATTR_MTIME)
>  		inode_set_mtime_to_ts(inode, attr->ia_mtime);
> -	if (ia_valid & ATTR_CTIME)
> -		inode_set_ctime_to_ts(inode, attr->ia_ctime);
> +	if (ia_valid & ATTR_CTIME) {
> +		if (ia_valid & ATTR_DELEG)
> +			inode_set_ctime_deleg(inode, attr->ia_ctime);
> +		else
> +			inode_set_ctime_to_ts(inode, attr->ia_ctime);
> +	}
>  }
>  EXPORT_SYMBOL(setattr_copy);
>  

This patch fails to apply cleanly to my copy of nfsd-next:

  error: `git apply --index`: error: patch failed: fs/attr.c:286
  error: fs/attr.c: patch does not apply

Before I try jiggling this to get it to apply, is there anything
I should know? I worry about a potential merge conflict here,
hopefully it will be no more complicated than that.


> diff --git a/fs/inode.c b/fs/inode.c
> index 01f7df1973bd..f0fbfd470d8e 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2835,6 +2835,80 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
>  }
>  EXPORT_SYMBOL(inode_set_ctime_current);
>  
> +/**
> + * inode_set_ctime_deleg - try to update the ctime on a delegated inode
> + * @inode: inode to update
> + * @update: timespec64 to set the ctime
> + *
> + * Attempt to atomically update the ctime on behalf of a delegation holder.
> + *
> + * The nfs server can call back the holder of a delegation to get updated
> + * inode attributes, including the mtime. When updating the mtime we may
> + * need to update the ctime to a value at least equal to that.
> + *
> + * This can race with concurrent updates to the inode, in which
> + * case we just don't do the update.
> + *
> + * Note that this works even when multigrain timestamps are not enabled,
> + * so use it in either case.
> + */
> +struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 update)
> +{
> +	ktime_t now, floor = atomic64_read(&ctime_floor);
> +	struct timespec64 now_ts, cur_ts;
> +	u32 cur, old;
> +
> +	/* pairs with try_cmpxchg below */
> +	cur = smp_load_acquire(&inode->i_ctime_nsec);
> +	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> +	cur_ts.tv_sec = inode->i_ctime_sec;
> +
> +	/* If the update is older than the existing value, skip it. */
> +	if (timespec64_compare(&update, &cur_ts) <= 0)
> +		return cur_ts;
> +
> +	now = coarse_ctime(floor);
> +	now_ts = ktime_to_timespec64(now);
> +
> +	/* Clamp the update to "now" if it's in the future */
> +	if (timespec64_compare(&update, &now_ts) > 0)
> +		update = now_ts;
> +
> +	update = timestamp_truncate(update, inode);
> +
> +	/* No need to update if the values are already the same */
> +	if (timespec64_equal(&update, &cur_ts))
> +		return cur_ts;
> +
> +	/*
> +	 * Try to swap the nsec value into place. If it fails, that means
> +	 * we raced with an update due to a write or similar activity. That
> +	 * stamp takes precedence, so just skip the update.
> +	 */
> +retry:
> +	old = cur;
> +	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
> +		inode->i_ctime_sec = update.tv_sec;
> +		mgtime_counter_inc(mg_ctime_swaps);
> +		return update;
> +	}
> +
> +	/*
> +	 * Was the change due to someone marking the old ctime QUERIED?
> +	 * If so then retry the swap. This can only happen once since
> +	 * the only way to clear I_CTIME_QUERIED is to stamp the inode
> +	 * with a new ctime.
> +	 */
> +	if (!(old & I_CTIME_QUERIED) && (cur == (old | I_CTIME_QUERIED)))
> +		goto retry;
> +
> +	/* Otherwise, it was a new timestamp. */
> +	cur_ts.tv_sec = inode->i_ctime_sec;
> +	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
> +	return cur_ts;
> +}
> +EXPORT_SYMBOL(inode_set_ctime_deleg);
> +
>  /**
>   * in_group_or_capable - check whether caller is CAP_FSETID privileged
>   * @idmap:	idmap of the mount @inode was found from
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index eff688e75f2f..ea7ed437d2b1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1544,6 +1544,8 @@ static inline bool fsuidgid_has_mapping(struct super_block *sb,
>  
>  struct timespec64 current_time(struct inode *inode);
>  struct timespec64 inode_set_ctime_current(struct inode *inode);
> +struct timespec64 inode_set_ctime_deleg(struct inode *inode,
> +					struct timespec64 update);
>  
>  static inline time64_t inode_get_atime_sec(const struct inode *inode)
>  {
> 
> -- 
> 2.46.0
> 

-- 
Chuck Lever

