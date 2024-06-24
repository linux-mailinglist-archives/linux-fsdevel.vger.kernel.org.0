Return-Path: <linux-fsdevel+bounces-22244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC79151BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F61B1F225B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE319D8B1;
	Mon, 24 Jun 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nJYEWMV8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YzGBHQ2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428419B59A;
	Mon, 24 Jun 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241987; cv=fail; b=ugMX5TLEq/SX8gJiYk1cMVwDmjsIKf4t9j+XJ1GCEHwN53r38opLpdcj2t3ioa5kfnDG+JUR+OAVdxCDOs1FTbi8cjI1C/Wwj9CEDquDOs6wO8uKZCEjqqnZm8TqX02jybWnSHB8r/8wRWs7u1x1BIis7njswFykvEPLwZptIcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241987; c=relaxed/simple;
	bh=Y2lxvCpktQ/ZRnDS25CIug47SZLiBhBIUtC+0JpRPNg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PxTQZPGLYlBbJgLbs20byEnsYJc7wHzacQnTYS2+44XE48KsR0Lc7cZ13OW6wV2rvEt85dpjS7kOpvxVcL1uT0A++vgy2Sz1ns7dhv2UPcZBy6+6YrCBCe/LRAXAs0MiE0KzsJlvZTfobYAKWKkiqoHs08lUtGgC8k67a77WhBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nJYEWMV8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YzGBHQ2J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEtO4W006272;
	Mon, 24 Jun 2024 15:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=XtwurnpAak3s7iFyzME1/4zOhQ9rxuX+xtS4b1Per64=; b=
	nJYEWMV8WobHvhrsJqN/fQPVc/BHvYAd9frewR4E3Ttjxx39spA+J/zbceg5p5DT
	3DH6TEr+rWVFN8Nqzz8QMX+4i4IKYZ6zXCNHtaZC18JOQy/2K02MCbyT1zNyG2dw
	gx9Iv1rqa7grAZGY/D6FxO/VXIbmuOdkER5vWofksdaUcdSuKXt+C2dsleNjSVJo
	CJmDAxcyUW7UaMycsJvX+ikRfSeH0gWTs8bx9Qq52SCg2JHwHY/He4L3/V7o7ZEV
	e629aNc0J4IdzcQVbUTYzUkY7UwJfCHNnCYBK8EPy48+QqgtXMtKwdkxB8aY5uP2
	sLYiZerqWlnAo965qaLIRg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5stvk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:12:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OFBoRu017850;
	Mon, 24 Jun 2024 15:12:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn262thh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 15:12:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2gHzchn1h+Wjv/qYaABz3MyawF0KP+SQcMPXOkQyoodY7wPIJ0Yjy2KKXEm1NESoMeNw3d/NwoXd7jjmr+21hSaCflq9dDJJF2xs8UD8L8HAivRzyR5vnC+nvQ0kAywXNKE03hWFM+MM9Jadu0M9201tk5IMHe7eyBliMVJ86JLgSt0oQ83ovTHIfz6/dxwZxChMbYS4lBDH6jsHnoNw00Difq8oflNbXxQk5XHsfzz1AyAWp/1I6xOP/4Ccaax1tZxG5cpffKnj69yLAvjUheXADpzQLClx51mY8JqR+MoG+9SbSINKVg6ZG/IZYwxt1CNoXwOXWdQuVCb+GK7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtwurnpAak3s7iFyzME1/4zOhQ9rxuX+xtS4b1Per64=;
 b=nSzB/k+zyq2y97UM7dwejmySypMgoT72F+Px1s47E+x77v7UgDVZbVg3l4hLIqmy9sAu3KcdusSeciyuzwlwWjW1P2kigoHphGRFXz32nD60+sS29fdpk+O5/HKu4Oxa7X7Tc9aIz4ZiSB1dzfIzaRAB9WCxyATv58C9/zEq1QlltLnheX9A9vXJ0l1kOF2IfVvXF7Ud7vth8hmIGoYTplECs1f3ApfCyxJsOSVD2ibGt0kIajMc+B+JbdW9AXjYzhwnnvPw1slXU1iXbdlGMobClXD6ZMs5lLaO7l9h8oXasiILiizvm06bG5ewC//mYY5qMEMrInLk1DLWFwmvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtwurnpAak3s7iFyzME1/4zOhQ9rxuX+xtS4b1Per64=;
 b=YzGBHQ2J5gJt8P/EKGphFo8hoUYIBYxwpG43yRPELNm/MSJFbkRS72cUR8EwUNBfsB3PDyjqKksneWb07qPB31VKcl6uB5ez+Wv3EmsVLhzw199LQRYisWs1KFhsN3BHNcKrEgS57Pa6zFdHSvGqyzn+pbsmGauJY8Ud7hToe9Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7223.namprd10.prod.outlook.com (2603:10b6:8:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 15:12:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:12:53 +0000
Message-ID: <6940956e-e2fe-4767-a539-825a345a9236@oracle.com>
Date: Mon, 24 Jun 2024 16:12:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] xfs: Unmap blocks according to forcealign
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-11-john.g.garry@oracle.com>
 <20240621191247.GO3058325@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240621191247.GO3058325@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed5dfc6-4235-4fb6-6504-08dc94601e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZUluODdoM0V2Qm9ySWNKeUFBQmZTZkIrSk5TMEtUR1RlOFRtU3hOemgxZnZ0?=
 =?utf-8?B?Z2Uvd0JLMEJmMUpxME1qUGFBUCtVYmVDTWdKbEI5TVRRbDhaQ3lwZ3ZkcCtm?=
 =?utf-8?B?NWk3QWYxbVlSbEs1UERXbGV3RHZ6VGxJV1ZIWC9xZGZhMW9iNERuUUorZWxD?=
 =?utf-8?B?VGZNeGROazdnaWpNRDJhb0RrWDBMTE41SG5tNFhNcER6T3VvYzJiRityR3lJ?=
 =?utf-8?B?RWxXY1RFSDRhUUdZYXBvZU8vUFByd0MzaEdlQTlXeXR1WVBBczhQZmljcEM5?=
 =?utf-8?B?K0ozb1lsNjdNNU9WVWUzRS9SQ21DUzlETUtRb2RySjFmSUVmQlZmdXgrRlhu?=
 =?utf-8?B?YndFNGFpN3RFUTRTR1ZMN1JKNmIvQkRNU01IM2RxdzNlcnB3YXNnWWw5ZW91?=
 =?utf-8?B?ZG9yUEE2SVE1eTJVSEtIalZtOTNIZ3BPSWFGN0xIOEMrRGo4a0JGTUxkdzRl?=
 =?utf-8?B?a1Z3Rm1xU01WTk8xN3A3MUpyditKMHR1SFhVSjJ0Wk8xZFYvZ0k1eDFEVGR1?=
 =?utf-8?B?NjQ0cERtWEtHV2M1WC8vb1E0UHN6TytEYXlPZENsNEJBL1pON242S0s1Z1c5?=
 =?utf-8?B?UFMvN24raTRoTTZ6RHRMSi94NUtrMHZWQStrelQ1WkZ4a1NqQTNKQkVmZ0Ft?=
 =?utf-8?B?Q0RXckZKQ0RaUDNrajhXQkZaZElpWWpLVzRXZElDN3dwQzBtOFk3UXFEUW9V?=
 =?utf-8?B?QU1taWlXdEFuUTFKdmNIQjVjOEg5VnpyRVV4eFBVZGhXWTJBcUhqd1dHdjBB?=
 =?utf-8?B?TWh5MnhOVkwvazFZVVZ0M293WWJ1eUJERmQvL0IxbjJwandZSExuR3NTRC9j?=
 =?utf-8?B?ZzA0SHhRREJBN0F5ZXRaOWZneS9jbkxINVZQTGtRZkNVb3Z5eGsreDl4eUhj?=
 =?utf-8?B?N0wzSUlnSUVBV2dRZVh2QWt5ZmQ2VHlOTjlkb3VFOWtnKzhnRTFwa3BOellq?=
 =?utf-8?B?RE9zNytQNFQ2Snk5UFdRZG1XQkFjbzU5RmsyR2JFRURBVHY5TTN5Z1lsOU1l?=
 =?utf-8?B?bWw2S3Z6cFJNMERjbmtTbW0rbVJCY1EvTWc1YzM1RVA1V2tob0RqMDFLYmRv?=
 =?utf-8?B?ZHhTZ3Y0OVlmUHliZzVpMTQ0V0hPYkdRRDRQUklnWVk3S2NyTnV4QTltT1ZB?=
 =?utf-8?B?clAxWEZjM3FJclJvQ2pLd051dVlJKzZuZ0F4OXhLT1Q3cFI4eWZ5QnRaYkFC?=
 =?utf-8?B?RWFwR0dDSjdMWUFhaWZ4b3RlclZJMUxxVFY2bnJkdmFubk1jZmtodUlxbGJw?=
 =?utf-8?B?YXZFT1ZSUnlLdXRTRWxHODdad3R2Z1BzODFpaGZocjMvUTdVR3A4Z2ZSaFRB?=
 =?utf-8?B?ZmdqVUtzbUc0Y1R0ZS9KZ2QrVlE3L01rSHE2ZkYzMmIwdjhlVEpHZEpTNi8z?=
 =?utf-8?B?cWk3dlJtd01tOGVxTGx4OEtpMWpIQ1NmRVdDbXFCMmd2ZVZwcXAxRkFCcGQz?=
 =?utf-8?B?aGlvK2V6VW5KL0F2NTJ5N0JnQSs2a1RyMlgwUGFHRlZDSEl3UjN3L2lrUVlq?=
 =?utf-8?B?S0FXa1NXSzFJazdTOVRIVHRrcEtFRHE0VUFPbWUzNSsza0hwQ3MvcWt1RFJk?=
 =?utf-8?B?SXhuNmZObjdPc2djbmprdXdXNVNaS3ZKZThvQXhuM3M4RWJPVW1xM054VzNG?=
 =?utf-8?B?NmJEKzJYVG1HbTkram9pelVGN3RyZ0laRWFDTVUzNmlTb3RTdnpOajRmQWlq?=
 =?utf-8?B?UTU4eVdvT01qNmZsY000amM0RTBtTlFTUDJKdjllUk5HamYzMWZKcWlnd0Nh?=
 =?utf-8?Q?s5M6Nf94QLw1w+9xh19scLfJ6Lrewk/vXzeSZde?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZjJZckRscXlOVWc1V0RURXRacjdlaWtSNXZ5OHR5K2tqRUFhdE03SWMyWjVo?=
 =?utf-8?B?MUQ5N0FpMDNpbDZXeStzQVlBbTJ1VCtOOTJLYkwrMTU2WHJyS3FQTDdjSkk5?=
 =?utf-8?B?VlpmQTRQaU9yZEFDTkI5TGprbkhwa1h5b2c4NW9aYklZQ0xua0lzSWxlOTlG?=
 =?utf-8?B?cjdGUmNGWlF3L2h1Unc5K1Zoc1h4dVFRbk9zMzJYUHMyVlR6b3kxVWpIRXpO?=
 =?utf-8?B?ZVUrcVNHbnI4TzY1UVcwYWNFME0ydnkwYUdOMlZhSWtYckpxQ3lkTU0zL2FJ?=
 =?utf-8?B?cVk0cjZTNXord0dvc01RTHFCSXNJcmsvRWdsdTN4UGlzME0rV3dGNzJFdC9Z?=
 =?utf-8?B?SUZpL01ia2x3cmI4Nkt3eFA5bGc2aW1zSVA3czZuUjhKMXZKNjNSQnBRbHZI?=
 =?utf-8?B?UlUxVlNmd3VHa2lBdm9xamVnSDg4RjNuYllMcU1oajlSNUJuU0g5QlhyeXl1?=
 =?utf-8?B?VXRjaVpmMFlnUHZDUFJTdUxWRWNOS29SNEhtRTRDckZBOXYrQzQycW9PYTEw?=
 =?utf-8?B?NnpDa0ZYNXprYXBXcFRjRE54T1pLSGZkeUgyK3Fvd1EyZHNHYXRwRExVVjd4?=
 =?utf-8?B?QWlyVSs4a0hWODJrZWw2WFBkSm5VbnU5eDF4STVocTFFVitDZGVBcXoxRm11?=
 =?utf-8?B?SmxYZGNzaFhGMGxxd0x4Wk5URGwrTW82NjFkYWdzSUZhMWFFYjdEWmNOWWRa?=
 =?utf-8?B?WjNSY1paUmRpKzJLc0RjR2tkUFROaUFwaDlPd3o2eGFscEhGSEU5V01zdkV3?=
 =?utf-8?B?V3hMZFRMZXBZeFNrMWljbVZKY3FPaHp5OVRoYm1wVkQ3UkhVQ09JdXpqZDFt?=
 =?utf-8?B?M2NOaDZ5VkdjczJaNG5lcXFab25VMGRxSktZS2w0U0R0TG03S3ppSWdDS1dV?=
 =?utf-8?B?REZHdlM2ZlYrSTlHSHlReTc1d2Z6QTY0WHRza0dqSzErRWd4RTZsczZyS3ZS?=
 =?utf-8?B?Q3hURTJhQWxmRW5TNzFUVVBnSHZ3SXp5cWpKVnZHUkMvSWtsMlUxbTNRZkJT?=
 =?utf-8?B?L3R2QlVyV1YrNXVraUtaN0M3ZGVGTUxGWWhwd0M2Z21KNVYydzByWk1ZaGZq?=
 =?utf-8?B?RTlYTWcxNTFncWg2eWoyT29ldklCeForY1RWZEJucVNPTXJCZ2psbUgyL0V1?=
 =?utf-8?B?UWxJUUlWaWRZSFJseVVVZTRVSjhrN3RzcG45OG9Bd3cvRzA4MzUwOGQ1L1Fx?=
 =?utf-8?B?UUFhdmowMENVWWZKeXpNM3gzUW5NNWVLM2xwUmwvUEhmYjFGVnQrVk9PSSsr?=
 =?utf-8?B?azZjR0FZeGFzL2tOSVloaDFqOVprbzRkWGFXd0xsTTR2MkJZbk5IZTQ1Qk9i?=
 =?utf-8?B?WXZsbHNKRmM4WUdsb2lEcXZKNnk0Z3lYcHNVYUpNQ05CMDJWelNPd2ZHcWJs?=
 =?utf-8?B?a1RHM21pR21BN1ZJd3kyZTVrNDBDRXhIbTBObjdSUkNJYlJRUWhpVDBEMGhQ?=
 =?utf-8?B?QmpyTzBrKzlDZWhDRmFDVExVOEk5TU0vaXIrYU9rYm1TOEhsQzhJZ0tkMmVt?=
 =?utf-8?B?RkpSckM5ZCtveEVmb0xibnN6UzVxVGwwcnFyQnY3ZEV6QzRuWE8xVHRPc3BW?=
 =?utf-8?B?OC93YzRVT1dkR0pGT29wUU1oeFpRMXY3aTVPYzBFQk9HVjQ0ZmxPYlYrdUxS?=
 =?utf-8?B?U2E4ZUM3MnR0TmhtcitaRmxxZmdKY0VvU1JYNXB4N3JrUElYak96ZkdTVkg1?=
 =?utf-8?B?S29aejhYZjFOTC9wbS9pSHBlcE5WMFV6eUMyNUwwTW9oUmVFUm5QM0RROHc1?=
 =?utf-8?B?Tkh1YTRSYWxid1hmTTZHMGtFcENhTnMvRSs1dEJyVTVvRGlNYjV4YzFhQmVL?=
 =?utf-8?B?Mk1NcDFDWEFOd3ViOVA4elV0WnFyd0FmaEZhdFA0YzU0VllJY0g4Q01UbUZG?=
 =?utf-8?B?RnJycHF4WkhHVmZDWXZTTmc1RHpCSnBtYXUzUTR3WE1hMVJMTlZERmhlekhE?=
 =?utf-8?B?OWExaTJ2dUdCSkswMVdZbFZSS0kyTERuYkYybER3MmhreDNBOHBobFJtTkc4?=
 =?utf-8?B?YTlIVXNXTEgwWm1HV2wvbitkQ1VLd3huWkh1UmExUjVEckJuU2ExeHZ6OUZs?=
 =?utf-8?B?OTgyZjJmdldBWVk1TzZRWjNBakQ1MDAwQWg2eWFlZ0ZQKzNiK1Z3bmdjNG14?=
 =?utf-8?Q?ZUOYxDvXhnA82ZBykEDQbjg2J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8yVJjheKIZ9PXFyvWeHDLx05UGGFoMqa0D0CzAocA4jgQRC6ji5Jx2awwINAVyn+fvnE2pX8bp5bb4uSROGaHH2eiWcStx07ks/y4FV0cT7szUTuicTfSgyj9JeyFsRlm9D/qe2aY+ebZGZw8IZrZrzbYW996lRCDQofB1pPJyB3qpeHcXjUJsFVGFKIJSER7os2aW4nTYM1oz/Uo+PzZO3wvYpUyOICajj0FobThpHhRPP8hN1jLzBVwq2ikAIA7eHG+qU8XjCG5KQQckDqp6rWfR+ebRPh0soHJmrXOtNdckrU7M+uC+LQmtFEaFmpAlC/akAVff21gymMfLP4Dz8r614tHmizlyjSIjVI4wyQIqCagnOwfEFhf3npXG9cuFLvRweg3wea1Va5vKXTpXINPeV3a8CWmKxWz3jcdPbf0omxpUYr0QTWRLb0kcJsK6Y1ktWC5Qp3DIEqbp4OH9F3AlR3UnICtN6nNqf9tD7aKu35XAA1XqJLPt73YjPTIfzxUNNLT3gPTjgi6bcjP+AzZniIfT0A2Ro3B2eGXi/v3IiWBJ10VdjkYeD/BIFlPryuq4hKMDYeQkB1ixU3KReQ9N910Qsy/6O1YLZ+dxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed5dfc6-4235-4fb6-6504-08dc94601e7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:12:53.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+N2Hwq/ueuFQgfdhUZHxKJITeoD12PKDaYCH62RDAclA8ZIQ125bB0Hwt+gS97wFgaGWndBlgdUs7NUWzYzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240121
X-Proofpoint-GUID: KbGH-suu8B1WFK_2epo18SqS_hyvUSYN
X-Proofpoint-ORIG-GUID: KbGH-suu8B1WFK_2epo18SqS_hyvUSYN

On 21/06/2024 20:12, Darrick J. Wong wrote:
> On Fri, Jun 21, 2024 at 10:05:37AM +0000, John Garry wrote:
>> For when forcealign is enabled, blocks in an inode need to be unmapped
>> according to extent alignment, like what is already done for rtvol.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 38 +++++++++++++++++++++++++++++++++-----
>>   1 file changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index c9cf138e13c4..ebeb2969b289 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -5380,6 +5380,25 @@ xfs_bmap_del_extent_real(
>>   	return 0;
>>   }
>>   
>> +static xfs_extlen_t
>> +xfs_bunmapi_align(
>> +	struct xfs_inode	*ip,
>> +	xfs_fsblock_t		bno)
>> +{
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	xfs_agblock_t		agbno;
>> +
>> +	if (xfs_inode_has_forcealign(ip)) {
>> +		if (is_power_of_2(ip->i_extsize))
>> +			return bno & (ip->i_extsize - 1);
>> +
>> +		agbno = XFS_FSB_TO_AGBNO(mp, bno);
>> +		return do_div(agbno, ip->i_extsize);
> 
> Huh.  The inode verifier allows realtime forcealign files, but this code
> will not handle that properly.  Either don't allow realtime files, or
> make this handle them correctly:

ok, so XFS_FSB_TO_AGBNO() is not always suitable

> 
> 	if (XFS_IS_REALTIME_INODE(ip)) {
> 		if (xfs_inode_has_forcealign(ip))
> 			return offset_in_block(bno, ip->i_extsize);
> 		return xfs_rtb_to_rtxoff(ip->i_mount, bno);
> 	} else if (xfs_inode_has_forcealign(ip)) {
> 		xfs_agblock_t	agbno = XFS_FSB_TO_AGBNO(mp, bno);
> 
> 		return offset_in_block(agbno, ip->i_extsize);
> 	}
> 
> 	return 1; /* or assert, or whatever */
> 
>> +	}
>> +	ASSERT(XFS_IS_REALTIME_INODE(ip));
>> +	return xfs_rtb_to_rtxoff(ip->i_mount, bno);
>> +}
>> +
>>   /*
>>    * Unmap (remove) blocks from a file.
>>    * If nexts is nonzero then the number of extents to remove is limited to
>> @@ -5402,6 +5421,7 @@ __xfs_bunmapi(
>>   	struct xfs_bmbt_irec	got;		/* current extent record */
>>   	struct xfs_ifork	*ifp;		/* inode fork pointer */
>>   	int			isrt;		/* freeing in rt area */
>> +	int			isforcealign;	/* freeing for inode with forcealign */
>>   	int			logflags;	/* transaction logging flags */
>>   	xfs_extlen_t		mod;		/* rt extent offset */
>>   	struct xfs_mount	*mp = ip->i_mount;
>> @@ -5439,6 +5459,8 @@ __xfs_bunmapi(
>>   	}
>>   	XFS_STATS_INC(mp, xs_blk_unmap);
>>   	isrt = xfs_ifork_is_realtime(ip, whichfork);
>> +	isforcealign = (whichfork != XFS_ATTR_FORK) &&
>> +			xfs_inode_has_forcealign(ip);
>>   	end = start + len;
>>   
>>   	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
>> @@ -5490,11 +5512,10 @@ __xfs_bunmapi(
>>   		if (del.br_startoff + del.br_blockcount > end + 1)
>>   			del.br_blockcount = end + 1 - del.br_startoff;
>>   
>> -		if (!isrt || (flags & XFS_BMAPI_REMAP))
>> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>>   			goto delete;
>>   
>> -		mod = xfs_rtb_to_rtxoff(mp,
>> -				del.br_startblock + del.br_blockcount);
>> +		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);
>>   		if (mod) {
>>   			/*
>>   			 * Realtime extent not lined up at the end.
> 
> "Not aligned to allocation unit on the end." ?

ok

> 
>> @@ -5542,9 +5563,16 @@ __xfs_bunmapi(
>>   			goto nodelete;
>>   		}
>>   
>> -		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
>> +		mod = xfs_bunmapi_align(ip, del.br_startblock);
>>   		if (mod) {
>> -			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
>> +			xfs_extlen_t off;
>> +
>> +			if (isforcealign) {
>> +				off = ip->i_extsize - mod;
>> +			} else {
>> +				ASSERT(isrt);
>> +				off = mp->m_sb.sb_rextsize - mod;
>> +			}
>>   
>>   			/*
>>   			 * Realtime extent is lined up at the end but not
> 
> Same here -- now this code is handling more than just rt extents.
> 

ok

Thanks!


