Return-Path: <linux-fsdevel+bounces-11350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A182E852D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 11:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BC91F25C1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91F37711;
	Tue, 13 Feb 2024 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mOD5doB6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mOV4gOnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7644036AEF;
	Tue, 13 Feb 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818368; cv=fail; b=FUi/ANeb6fGJQptMqjUUHZ5cVbtL2a2FGvte+XWWttW3eg5cd9ga43XKdk2DlHcEshSKSbUGHaVN74/L7mT8kwU+30mvTp7JCqcMdEBeerQzovdf8qP6cqCU8jmGlHGxSSmpGsmwsHgpRvrGdjubdxyf5glrSqXiFzrGKWYuTVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818368; c=relaxed/simple;
	bh=TUjdbx+dB703gU/kRLaExtSyMor4fZ4qbeba8JwPco0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EoT69/t7o+7+dTWY4wtH4RLbjPV8LSDg742vHT8zBXM/wWAHP12g7G2cQpvUt5d9LLpOgvbCeRz8DmNxBZGI5bgC7hYKTVHgE+XmW+HP2v21SI1CiQt4DdCuGl4e5Qf/fTPAUr0P83ChrPSf0H+5Uu2Aedbl86v3/pR7jLR+mo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mOD5doB6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mOV4gOnx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D9Hw6Q027364;
	Tue, 13 Feb 2024 09:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=f86vHl1kOQ4utdN9O49TKzBGIgZ/5aWeCDACVZgd9dU=;
 b=mOD5doB6rOBzVTYPSZY2mLJlJCYMz+uATpFY0ZkunBBujUF+amjWppgCaAbhWsYQvOLp
 rbUYB4TktPGpmFTgLyfzXCnwr8luzYH8eoVbUEH43ju+mxdchxRme5tyVW5bmEL1i9nH
 hONn1JkQy76FUz8NunidXqFcsnu+poE7UOcRYm++QPbvOIsS+31EexMBsTmr56mAOV9H
 MO/myZ2Bz3sD9CAeh8zcLt57sfhqT0ooAHc/qqqrzvUn9OYcysFjK96GMCUsrM76Pnhc
 Nmmm8pUAezy4YCcFdZgaTbpLuw9NhyLbdjRV9MyoU/WuIUEubyHo2SlDhB4xGrDRAYuL eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w80kvrmc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 09:59:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8hQ9Y013952;
	Tue, 13 Feb 2024 09:59:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap9sc0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 09:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4tQmGnUd37y1bb+dngHcphY4M1zKetkG/JuyEvv1c1SkBNjEiznOTxTm48UhibqsbBA4BFralQE8eDRJkkL/awB3FIkQVeFH6SxoS1Cp8BLpSNJIxv/e7wIFm8A0xZblXxMxFxThll8ojP8FPUtMoHMey1FChWqzXB0epND+A6eLY5oIbXWIjbcF/Z73qcjtn7BCL8mP2BFHVoQzTcBUuiXAHQ+SZPHYIV8C5HlOSOfoYcB5+OLhaRLkAbd5ZsIzj0g8IrihUWoIFXCaAUJdwlJn9gnRSq314gNcehgTgyXyoq87V9sE3DMb6JWbZrlXSvq8faBD+oT0FfyDIPoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f86vHl1kOQ4utdN9O49TKzBGIgZ/5aWeCDACVZgd9dU=;
 b=ew1qGMku1n819ksY4wdNc7/obeIJcj5IpO1GyghdTg1hDDP5ttu3QZTHEmF8GfeocW8SjEZOalEs73YOFCt4Y4CjhB/YdMbPOEYKwXG39WeGZEiMVnQTcGU/eOJDX7z8HnafRX/7s/xMqhaIVeR07k2vxoAKRPkXapToJEKkqsMFI6udab/Zn7X4q10MsBsx3BWfMFQ6lxJYkur/pbHvN+amGeNKKlszj7xruhlVwiWlAyNAvz420XpzLaQBQwAZwESlPpt0UkHgVAcxBRBLwBOvBhSjW+G+ogIwVCAFuZhg/+fpwEap4202fRJmnH7WgCnpvjNy6sWSqVFnD/OHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f86vHl1kOQ4utdN9O49TKzBGIgZ/5aWeCDACVZgd9dU=;
 b=mOV4gOnxcfNERmuMbY0Z0hlCx6n0xSyjkJ9UAYZz69cE+cIMLmbhwQzQL5OGoCZWF5A2WfUjqZbpbmLJa0cFdkuO3t+d2hrUn+bCGDWdHRahaiHJjKiPxntf7Jn90L2ffDXOqUeUDHAb9Ahs5jPjpWBg1k7x7uUKSbd6a7ZWyLU=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA0PR10MB7381.namprd10.prod.outlook.com (2603:10b6:208:442::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 09:58:57 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 09:58:57 +0000
Message-ID: <9ffc3102-2936-4f83-b69d-bbf64793b9ca@oracle.com>
Date: Tue, 13 Feb 2024 09:58:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] block: Add fops atomic write support
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-11-john.g.garry@oracle.com>
 <20240213093619.106770-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213093619.106770-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::15) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 27043f69-f74e-47b5-f057-08dc2c7a64f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sXPy1innQCxGfal7IMoPSknWeCCXmSnPg2m4qKmvpRTIt9tqz3xIntS9PUYSL6dbT1feU1BUsVy0enngYZC07tnFELZh1WK4+4wfAeoZKWlnpT5lodoUzHyGLkU//XmUpR2W0yo9jfPLAx2heN8vRZcZkNZfwBWQn99kWe8wrJ08YnAFSwV9IwLzsHoqe7diRg5FuKGSxedf5JVczEBnun8Vvi3DrfzAu2L5xU9yvYRSbKcDQr/LSKME8xcglnFYq/mrrarWEMo4rCSCC9ykWx8BRHPsaIPoJ1uCyFZw2j8yO2t6R0KcaBTW0/nSKWcWDZ9hMYfZNCJLqFq/GEbWPATkQV2N5VZR8j42jQj2CBN4Yz0GrLDJIbAeU5bRX2U1Vjm2488An/IwfSp4TOpM8ZrenmvUtqvAVgcK9dRvHdXaGHiZaH+lRYaY47pjOWPfOoHBAUb4vcqNCa7AyeP6lbu0UMIzjMTToaot6geIme9s23aWRVEtwb75q5qWQcPs9GwQF3spi7ZEmHsz82P+XYGFuaAy45VLmsc8W0+jFTD+9YnmtsvRiR5TWMHmO2cG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(6486002)(478600001)(31686004)(41300700001)(8936002)(4326008)(8676002)(7416002)(2906002)(5660300002)(6506007)(36916002)(53546011)(6666004)(66946007)(316002)(6916009)(66476007)(66556008)(83380400001)(2616005)(31696002)(26005)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzV5N3hyQ292emdVQ2lNaDhINEpLUXVIZnFXY2FqNTZrL0Y0cWMyRXlHYjIv?=
 =?utf-8?B?Z1ppbU1yam5ITWh0d0Y0TzRJZlhrZUNoaXV5L0dwS0p0U0JreHl5STJZREpj?=
 =?utf-8?B?SVZDMnp6L3REU1pKbE5FbS9HMlo2bTErVGs0RWkwUzJhMzNPdGhKd0Y1dndB?=
 =?utf-8?B?TGxaWkRtbCthM2s3cC96Kzh2K2oxQkNDVEk3aHZJQ2dsdTQwL0U3T0lxdDNt?=
 =?utf-8?B?QitpNmkwNUVMdzVlbTdSV09jMzc3Y3ZvdXpPV210QkxtZDRIWmVxUG9BY2JE?=
 =?utf-8?B?c2JEaDBEY0plRHVxSWxVVURQc2dnMVBXenUycUFsaDRpNmpGdUZjcExpWmJX?=
 =?utf-8?B?ZmxXTktGN1UyK0JrODZRVE85aUltNWQwcEJUbjdpMlpuTmZWYTJpVnNJclVG?=
 =?utf-8?B?V014YzI1azFNOVdOQXQ3TEIyT3EyQlZCOCtXb1UxWjFxVjB2a2V1eGJSRTBp?=
 =?utf-8?B?Y0NHaE5oWnA0ZWJ1YVByVjF1MUdRTlB1dWlWa0Q0YlA5bmVqUEFmMXpmT0Jo?=
 =?utf-8?B?WlNQM0J6LzVvSmNMbFBUVHV0TmZlWmhpMjM4b0F3V2dheDJXVmxBcVlxcVpQ?=
 =?utf-8?B?TXozeTlFbG1CbWtjRGlKbXNxY1BMMzI4ckJobEFub1dHZTRKOWdoZ21ZT1dq?=
 =?utf-8?B?WU4vY1R4SSsyeTV0V3FndWhzVVlPc1YxU052QVVJUG5vL3JzRG5kRkM0UlZI?=
 =?utf-8?B?Lzl2cDQ4UzlXWmFwMEo0cFZpeHZOeHpIOGV6a3BjZ0JyUlRZOVVCSHZUOEpw?=
 =?utf-8?B?UU9VSUg4QjlDb2FGdXBOZncyY2xDSXIvRW41MC9NR2Y3NTE0emVzUWozOXZO?=
 =?utf-8?B?V0lzMldxdTl4M3NJQzNyQmlEc1hHbGlYTE8zaU1xU0lnZlh3SkRnc3paSEI3?=
 =?utf-8?B?UmpWc09nREhqQzVGS1FlNTgyNHdxUG1EeUtkTCs4WXp0RXdnQW1xWlJXaFVQ?=
 =?utf-8?B?Z1o4RVEzLzk2U1dIWTJDMDNkOURwb0p3QjFOVGVnVGVKYzk2SVl2bGxKZkln?=
 =?utf-8?B?djB1OVJqZHo2cVQ2MFZLMGJ2MDN5aDg5L2lHcmxnU1diZmtLWWVoSE1NTGs4?=
 =?utf-8?B?ZVpqNzllbUlSUzQ2K25aek0rWCt0VEpwSFA3S0RRZjZHbkcwS3dzYUwrcEhZ?=
 =?utf-8?B?VndnZ1loQlEwem5WenlQcml1T0l2TFhXYU9jN2NteHZ6NEZhK1ZDcEYzZVA1?=
 =?utf-8?B?bFFrUmQwNEtvWjlUVm8walg4WjJ6OUd0SzBNbDNzY1l1dWdzRDQxdGFNcTJl?=
 =?utf-8?B?TEVUUEEwR1N5TnhUc3U1UU5LbjREN3lYVGxGMWhZU0VZWER5QkIzUEZRcW5k?=
 =?utf-8?B?ajhZWVh1M1ZVQ0dtdmdhT1pUQmE3NjRFSnlkN2N0Q1NlbklHb3dpakx2TDZt?=
 =?utf-8?B?b1VXOE5kT2ZDMU05Wi9WaGJYVHRlaHYvUUpRemZZV1l3TWlpQVI5MGlaMnY2?=
 =?utf-8?B?NjViWHRsM0FvYUJyRDFHVnFrNHdhOVBjelA2NUNXa29sd1RTR0hGSW1DWnlP?=
 =?utf-8?B?em5uTG5naWFHOHNaNGtaNTl3eUhYTzBZaUdLRXNEWXBMNUlTVkpURUpxaThJ?=
 =?utf-8?B?SXl3YlB0RFhRM1Nvdng4d0lyeE1WZlJvZ3VDUUZSbjNIS2pVVTBNcEhyYUV2?=
 =?utf-8?B?MisvK1lOVzI5a292K1kwU25lYlk1RDRjQmlGR0NjMTk3Vk9pUWxEb1R4dWRE?=
 =?utf-8?B?YXB2dzdVbDdsRkhSRWFVejVqblVhREt1NkdKM1NSRWxLNFlOZkxzQTlEMU1p?=
 =?utf-8?B?Yk5laERkRm5EVWRZUkNPM3RDaFpUUXN4UEN5UGxPRXpKWFhiY2xKaERpOUNO?=
 =?utf-8?B?eG9SaXIvUkUvZ1VRMkwyaGdzYWpGNzU5T3p6akdNZFZ6b0tvVFFSSHF5T3Nn?=
 =?utf-8?B?RHBKYVBlYnM1SXJMSExVaFJwRTkvbFU1MjNIc1g3SUx6cXVRYndZbldER0Rv?=
 =?utf-8?B?dzNkMTd2ZWhCUFM3YjNFbldDNlVGRzJTdHhHTjdtcTFzVGdrb25tZ3BMTmh1?=
 =?utf-8?B?SGl5ZC9lVis3ZkRaOTVVbERmdWdEUW9mUE5qVENMWmNILzFGV296anlCL1lV?=
 =?utf-8?B?YVJWUEZjZnRoQmE2TjluOFFDS1huRWhRRUMycUpaYzY4VzhaNU02RHc0cjg4?=
 =?utf-8?Q?5rT3L4zDKzqPKmkeygP9EF9IG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NcM4BC8RX7GWD2RF9KNexc+kcMeJD/HIkQEV/VS5XpnRNR28yWpbn0mOirRFuNKXfTHzuuVtggfuFyKXmajWY32sBkVhCMd4eJWLCzURYkZ7QVFFx0bABln1XTwaGbG+Z2zW7Gj2ap5uQUVwCuNzlEA/Rvp+qzE1O/wNKXasWw5nukH1ynl5ZfNzxgrY7BbavP0dHwadnGlRmjI2qwPk+1+6G4FKQDM6JEqb6FajBkfek/nTlkxNn3vHmOg4y2gPVx8hNEvEgd8Wk68f07hJHBDer/cC6EGmzuivTR6dGmWu3KQMKPtTihe4Yp0B9hmVSytmcq3GGM7C0u61Q6adwaN2pHWVGHQWwBJ5QqmmmQPXUxeNI5ehto38Z2Bqq4hUy/iaPEJwGHUbyzq0XMjYuuXqcPeQzxgYzafR999UKrx31e5TmErahlG3kF7UGydXaZ5nHpWMdxzSLbGMSUaCpznO0CLNW8eztkGd/IVUFmoO34jjtFTK3/3XlN+9BFPPKW/ZAux09Ms5rVqItGdQMqcP3QKvW4t1xhBJeWDfVYtmuNH8X32z06MpyOvQMejCOeNIorprtUPdXLFeukP0fZBlDlVS/MRcU4x44r1ozlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27043f69-f74e-47b5-f057-08dc2c7a64f0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 09:58:57.3143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKUGKmt2k/A5xXRn/z8aNdwK0XbWfEMk3vuEnCGB2Hhl/7bXxrd2VO4FSXi5k5FdVj5DWJjpClchVC5WZzgB4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130078
X-Proofpoint-GUID: fXWQDQryLRdffTV1mDn-HgeU6RgyyiS_
X-Proofpoint-ORIG-GUID: fXWQDQryLRdffTV1mDn-HgeU6RgyyiS_

On 13/02/2024 09:36, Nilay Shroff wrote:
>> +static bool blkdev_atomic_write_valid(struct block_device *bdev, loff_t pos,
> 
>> +				      struct iov_iter *iter)
> 
>> +{
> 
>> +	struct request_queue *q = bdev_get_queue(bdev);
> 
>> +	unsigned int min_bytes = queue_atomic_write_unit_min_bytes(q);
> 
>> +	unsigned int max_bytes = queue_atomic_write_unit_max_bytes(q);
> 
>> +
> 
>> +	if (!iter_is_ubuf(iter))
> 
>> +		return false;
> 
>> +	if (iov_iter_count(iter) & (min_bytes - 1))
> 
>> +		return false;
> 
>> +	if (!is_power_of_2(iov_iter_count(iter)))
> 
>> +		return false;
> 
>> +	if (pos & (iov_iter_count(iter) - 1))
> 
>> +		return false;
> 
>> +	if (iov_iter_count(iter) > max_bytes)
> 
>> +		return false;
> 
>> +	return true;
> 
>> +}
> 
> 
> 
> Here do we need to also validate whether the IO doesn't straddle
> 
> the atmic bondary limit (if it's non-zero)? We do check that IO
> 
> doesn't straddle the atomic boundary limit but that happens very
> 
> late in the IO code path either during blk-merge or in NVMe driver
> 
> code.

It's relied that atomic_write_unit_max is <= atomic_write_boundary and 
both are a power-of-2. Please see the NVMe patch, which this is checked. 
Indeed, it would not make sense if atomic_write_unit_max > 
atomic_write_boundary (when non-zero).

So if the write is naturally aligned and its size is <= 
atomic_write_unit_max, then it cannot be straddling a boundary.

Thanks,
John

