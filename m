Return-Path: <linux-fsdevel+bounces-12296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FA185E4BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC8E285039
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5C283CD9;
	Wed, 21 Feb 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TCiWo6ch";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EkRhEgWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544883CBA;
	Wed, 21 Feb 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537159; cv=fail; b=m5IGP6Cy1YB8y4RqxibWeeOJ0nwtLlO9aAiXxf7TI6aKoy5RdjmTnDrFr/8eNeZnresxnYZqGs1xNmMRB0r07TrEeVpJ1ZE92aYKA27T75D8bKI9pDlokPW5vjx1ZF6RKfuEJLJgtb7ImcmgJLc+RwYAweEKTq933wyKltEHxVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537159; c=relaxed/simple;
	bh=3WN3JqizE4XFfXEmvNV8P8FgqiombNklV9426eUM5HA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S85AP9WX710RU631C2YlzjfZO4Z17DaXnAUhY80pv36to0jvJh95n3RygJsPuwr5VjX+Uu+z4P+u82OQ6RBUqjMa48cD7mA6ncWXUi66C2akonwWHzbtaQ/ZtoWFaZqC8+R30X0BsFi0uU67fb6frRVywME31Wi5GhwqH7CJEYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TCiWo6ch; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EkRhEgWD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDinND012105;
	Wed, 21 Feb 2024 17:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EQ14rKGMvmHz/AOqo+wuDinQVglAUP9NTXChIgsv/Eg=;
 b=TCiWo6chbpmLA2IS+9cvfNUlETf1JQ3mC6OcMXd22OjFbazldWMYHwQMJybjtXZlXm/1
 wUXsOsMqnqYmlaQDBfa1xCL6oCcsC/7IPHHniHKPF2DOa9KLg8SxkLpKzLCyLUdkOXSN
 Uemq5G64QVot1BeC1dTEqJxFx9A5wyTK92wBSO5VLOh3sTLnKlRZUIBpN+3eLfQD3cnJ
 S2aErTprF2Tw9Uswr5fxUwWmVwe2KGnWhebUuUcbXWYq8PN+V5PYqO/NcZeGlkrhalVS
 jM3WmZ7czBKQz9r3uyi7h1hUDhks2zg35vAPw459qrpDfxNcFlNTqiHHdy9JSF9hzG8F RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdu2dbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 17:39:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LGVlaD006627;
	Wed, 21 Feb 2024 17:38:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89k4jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 17:38:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNzBcMUPbG5vXziplDbQh5rGqbq1cLSB65RdtOVORBUpOeD0xyyvDsAp19H9lMRha+QAHdH9BOk3ybea/WDlvBD8xx4ee7lPIz21SBl30ZBJJoi4qtUR7QFulUEQpVoh5Ke2PsWL8DD9URySVzWn8N1/Y+10o4eBtlJ3kh1efh+Chx6lqqB5KKv+LV1aKSDzXgwkJ7ksKABZHhTWyzllIojqNUXlM5u6dW6ewDNGzclUQGqIKXYw1QtuAW6HzgpoOvUCGZzFV77/0rfgecIXElF3E7ksqVg9UkWLdAv9mNudNyX3KaZtVe5o11MwNIcvBHHh/GA6JCZ/F+66fyS6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ14rKGMvmHz/AOqo+wuDinQVglAUP9NTXChIgsv/Eg=;
 b=FrrshDFsE1lLgTvS61StjxnHJZfSefqHuQ+t6DBPdEbH5ORvYx42KOm7MLvM6yhn1wCpwtvpFdOh7aQmvZ3rx0o1F9T6Jxq5pMUVIg7v52fzJDMG5X4jxP9w/gp+uNp/7PXyE249h4s8/kSgfYp2E+RyZSwaVlJUDfM8mVyQ7Zv4P22zILrltvk29bT2ULlrPQsxrCPaYvIJZHUphSbUBD4SXugyd5J9F6CjqO9dNv5CrufAxx5Dyq3Bh78D6BRb/eCPL9tVrri13z5Xl6xi/CxPJ78K2yN2n1sO7Mk7T0heU0r7tNUebMc1GoNtAWw6V+3zipsck6GNdZwH2/viYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ14rKGMvmHz/AOqo+wuDinQVglAUP9NTXChIgsv/Eg=;
 b=EkRhEgWDcaVVe2rFhWYN2MA1EoSJAge/Voy4L9gNLfFQNVbnyZnFVyAQj9OdSBXIW+FvkgRJJtHycYRGgeeMpTNokuRgDTT9t210+CqmF5tO19s66ucXMCdeEYbzEPDRZi/5OnJCKBMx7e2Y6wgHC2DK9P9bWSJEernTI4AV2U4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Wed, 21 Feb
 2024 17:38:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 17:38:44 +0000
Message-ID: <f7ad3aed-3482-4eee-8c81-8e471916ef82@oracle.com>
Date: Wed, 21 Feb 2024 17:38:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for
 FS_XFLAG_ATOMICWRITES set
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-7-john.g.garry@oracle.com>
 <20240202180619.GK6184@frogsfrogsfrogs>
 <7e3b9556-f083-4c14-a48f-46242d1c744b@oracle.com>
 <20240213175954.GV616564@frogsfrogsfrogs>
 <b902bee1-fcfd-4542-8a4e-c6b9861828c9@oracle.com>
 <20240221170031.GI6184@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240221170031.GI6184@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0348.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ea3c53-38a6-48a1-afea-08dc3303f384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xR9P0JLlrekW3Q5lnV+FddJD5rwFrp0pvjnn0duzjOb5TJ4USY3t5eAYAO5Gh6YguQigprpltl63ga3Rzn0MmQ3vcHfca9im+8HZ9sSonpmE9AY0PKgMn1fuZ0Y5bYHKN1CdvyYtYO9aKoPOEmu0HE6w3BXLxVLmS6mJzbaSd/a8MIR/x1CIO/tG07ZOiqVk+/msg/W7D+0H8yL8pfmrQpX/TUpyzHMfWN7IJXGTOurD0axnswRv3z/TRHhZ3jz/7ZyNKw/RCu1W8SxGarNf0gUBqW0rWWv5N8Kh2IkeRGXvwWSW/udfeic5ExXt2r9cBBbFPy2Lbf0ZnY5WIbS/vx4KXA7ZVtfOYpOJyBF2Wv/ddsoaLXkvgSlOGIWt4tdKle+Y0l0xMsM2K0yPhqB80nBogQHZrECMLX3qO+AjSTwMBgl5EAC9x1VBwEUAm6E8NPI03GTpfup0hlBrR4Vp1mNwlj6VQnwAayaZiLAzZmStPloS83LrPDd2KLmh+cp7SszDQetNASS3KSmGQg9aYW1uAtxVtxcQJwDT6a82iPM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3dqWHBzRkY4UGZMWmxLb0NtdG1vMzRSb01TNzBrK3h4V1VIMVhqN1lDVUtH?=
 =?utf-8?B?MEdKMnYyMzQ4QlhBd2xrM05ZWkphTzYrZm50MFYzTkZMdXZpK1JtaWFVZVlC?=
 =?utf-8?B?ZTE0eDRDZERmZkh5Z3ZYVW9TWDBNQVIxVzZQRi9VdDlQV25ua0s1d0NiUFpH?=
 =?utf-8?B?OFZjci9kOTMzM1lVb2l1bkd2MXY5N2t1UjNlS1NzMUUwWDdBWlNQY0xONnpN?=
 =?utf-8?B?YVlGY1NtVGV5WU1pYTF6Z1o5eUhiTTZYdFVmdGRWY3dDUUE5R3gyVVgvcHJk?=
 =?utf-8?B?TURkaDdLamUvUXIyRlA4TytHL0h0NGZUVnM2Y0M2WXNtdk40Z2FIQldyL21k?=
 =?utf-8?B?YWRka24yWEpUNDRGbXJDS0NDdEZBWjViL0JCSTZBRm5hbEF6eXZHS2x5V0tk?=
 =?utf-8?B?a0lVUU56NDB0Z3NBQ2diWi9aT09zbzN5SDM2WDlGcFFWZStpUVp5TWRyTGZ4?=
 =?utf-8?B?UmV2UFZBUjcwODdvZzBzbnZ1R1NzYWJoSWMwcExZL3AvYWpyMzBJY3VqemZC?=
 =?utf-8?B?WTJjejVBYzlXaWU2bVNBZFZBdXJjMXlhTmNaZGZVakJsN2RjQkRaMnZYZStj?=
 =?utf-8?B?UU9PNDZwd0YvbXZYdENVTGFzd2Z4SW1DeGxmTUhYV2RCdGFmYjIzVWFFYnh4?=
 =?utf-8?B?S1ZrTkhPenQ2Qk4rL1ZZWVpGOTNLYTluejM3MnVMRXpPUkpDSFpDUDBabTN5?=
 =?utf-8?B?OHBUK1ZMVFRSMWxDWkZhV1ZLbGIzMlRLVTdyT3JwNS9lU0d1NG9Zb2o0eWdj?=
 =?utf-8?B?SmRCa0hHUVlyNlYvZmYycmhGOHV3MTZMZDV4K1pPV0N1QjM3NHRlSEpMODZi?=
 =?utf-8?B?N1A4WDZyclM4SG1ZeXh3Y21mak5Xb0dVZTF1d3VpWm5PWVNBRHEzcWY1RXlV?=
 =?utf-8?B?Z3M1V29Va3B2VzVtU1BTblZicHJoUmtMOHZvR2tHL2dDYjBic2hQeWpSN21J?=
 =?utf-8?B?bHZrWHArN1VKK083QXZyVUlQMW8zRVhwMmhPMzYvZlZpYWFnQmdSMTlZVXg0?=
 =?utf-8?B?OXdwdXBmWkdHNkNWN1lJK0dXaUlwVk1TNFhOczcwUDZNT1FYSEFiS3dBWk4v?=
 =?utf-8?B?NXNiT2tPNEE2Nm0rWTZrTllLdGJDVzEwM0tUNWpWc3JDUXJpQ3ByV2FVTUdj?=
 =?utf-8?B?ZWdLTGE0Rk5pN2ZwYzY2TmtzRGwweWtTeVVhQlF5T3pBSGcvTFRrcDdLVmpw?=
 =?utf-8?B?RkxobUt0VE94WGFOWUQvWUVQUnYyd1JjSUo5UENUODFnZE43emdqTFhQaUtL?=
 =?utf-8?B?aW1wYXo1em12Sy9wa242TURKOHo3Y3gxRnh5ck05T1BvOE9XaWV3bmtxdjly?=
 =?utf-8?B?QVM2cnBjbnpIajkwNXhwa0thVCt0VFFSNFNDWHR1akVCTVpxL0t2T05PMkgz?=
 =?utf-8?B?VTlvQk5MaW83WTM3YzlLb0RkVG8yclZqR2hrblYzdGx2MWFlQUtWZEdDNlhQ?=
 =?utf-8?B?OExROWVCK1NtRWVmaU9pb2NOL05UQ3oxa1dOWG14OEo5NHVLVmJJRTlFLzB5?=
 =?utf-8?B?bmV1QkFCLzh0YmpTRC9Gb0RWWVZNWnpJS1RGNlRsbVpubi9NSmRwdk1zRkVD?=
 =?utf-8?B?VXJ1Lzc4ZlNEOGlkbHd0WnBCcTFQd1BLWU0rb1BYMkhSZ0V5ZUV5VFVhNTFs?=
 =?utf-8?B?b1poaHAyZVFSdTNRVEhpd1J6NmJWUmNCelduYkp4ci95K05jYlZxanhQbUJl?=
 =?utf-8?B?KzBNZ2J2ZWlkaHFHV2xDdDBJcFVuZUlBUGp0OGc3WStOcTZoWFZJblV6aG5j?=
 =?utf-8?B?cGNkcTJlc0ltSjJTZ25BWXQrTUF3Zlh1VEZObTNINWdOU09PUzR2SHBKNU51?=
 =?utf-8?B?eitrZ1ViNlh5bHVYY29TeUpOeG5JSnRSSkJuWW5BQ0kycTc3V0JwUUNJUmlW?=
 =?utf-8?B?ejN0Qm45N0prZVY3OStDRWJ0RkdwdGtOaWtLMnltZ29ibFM2WENmbmdxc202?=
 =?utf-8?B?NTk2ZzczNjVheVlhNzZuRExLQ2N3Tk00VFJ4OGRuelhKZ0hJNjN6VHR0WW1v?=
 =?utf-8?B?Y0lOZFh2VzF5aFhjT0NMWW1lY0NnTUNnZjdSSWs3eU8zRkdsSFlUNnBlRzFV?=
 =?utf-8?B?NG4vTndubFA4MVhuTnQxL25iSENyV3lpREpwci8rZjY4S3Y4aGFNU0hMM0sy?=
 =?utf-8?Q?l6q5VjtcxdAeN6WxLt7pwS5kh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0uYbOInkbbheUhD7aSzLLAWaIYhlzTvCpe7dReO0ZvHskK2xRT/I35jls3vweEay1ZeBMIe9LRnz5w45NYnPKPvBDKrweT3J5tSzeg7BrvkdVjCCZUlyG91XGTMApjoLngw6xLAEiHwBmawUVcIQWBWh4oi3bzyKUSOtTacJAdmNJcdfL2+ppS6Liqule93IwOlbKsrt+Qy7K8HZiaWXgUXO6cqDQpT9F+tARd93pgFHX/mvx+NmuHD+a6KnKy6Z1qx3zpHo6UG8cUgL3Ml1mIE5xuZMbskxpCCvg2vdkTs5vbsccvBLz2TvtE16Tjg9RWYHNw6O1eVtJLeeFFk0QcldsFgXunCsdkdKsm76O9Tolph9ltmfoEoNLXoPGfjo+tuWb3wjDUXLNT3fSpq35rj0MX5NCMnmeuLySffR52aUkKCJg9pMtZWBHIf3LU7jc9S4Grzx0qOubdCe2Qjnup2mSTR5eiePLZQPX0xWG+RvBH6aDRGU3uQuAMzR6KXI8Dcu9au6ljkAngB6HWJJlcDtwvljrS1wznB4yRTaaguUH4qQaWF1hXNPMBIRFkTId0DDGAwjH7tcsiVMKxTuHYbx4RckIVD7D1FpwVDjoXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ea3c53-38a6-48a1-afea-08dc3303f384
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:38:44.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9B6+yF78A4AtJBTxlAM0gqrYoOVc3JweTCBtidnSqULCdxC9OmNzCtY24dDSyWs2zUAoN6+cyUG9oChmAvSdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_05,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210137
X-Proofpoint-GUID: HDrYK-D-mrZna6dDEvipkEYjyuqqGpzZ
X-Proofpoint-ORIG-GUID: HDrYK-D-mrZna6dDEvipkEYjyuqqGpzZ

On 21/02/2024 17:00, Darrick J. Wong wrote:
>>> Hmm.  Well, if we move towards pushing all the hardware checks out of
>>> xfs/iomap and into whatever goes on underneath submit_bio then I guess
>>> we don't need to check device support here at all.
>> Yeah, I have been thinking about this. But I was still planning on putting a
>> "bdev on atomic write" check here, as you mentioned.
>>
>> But is this a proper method to access the bdev for an xfs inode:
>>
>> STATIC bool
>> xfs_file_can_atomic_write(
>> struct xfs_inode *inode)
>> {
>> 	struct xfs_buftarg *target = xfs_inode_buftarg(inode);
>> 	struct block_device *bdev = target->bt_bdev;
>>
>> 	if (!xfs_inode_atomicwrites(inode))
>> 		return false;
>>
>> 	return bdev_can_atomic_write(bdev);
>> }
> There's still a TOCTOU race problem if the bdev gets reconfigured
> between xfs_file_can_atomic_write and submit_bio.

If that is the case then a check in the bio submit path is required to 
catch any such reconfigure problems - and we effectively have that in 
this series.

I am looking at change some of these XFS bdev_can_atomic_write() checks, 
but would still have a check in the bio submit path.

> 
> However, if you're only using this to advertise the capability via statx
> then I suppose that's fine -- userspace has to have some means of
> discovering the ability at all.  Userspace is also inherently racy.
> 
>> I do notice the dax check in xfs_bmbt_to_iomap() when assigning iomap->bdev,
>> which is creating some doubt?
> Do you mean this?
> 
> 	if (mapping_flags & IOMAP_DAX)
> 		iomap->dax_dev = target->bt_daxdev;
> 	else
> 		iomap->bdev = target->bt_bdev;
> 
> The dax path wants dax_dev set so that it can do the glorified memcpy
> operation, and it doesn't need (or want) a block device.

Yes, so proper to use target->bt_bdev for checks for bdev atomic write 
capability, right?

Thanks,
John


