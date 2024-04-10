Return-Path: <linux-fsdevel+bounces-16610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215DF89FD88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAC284892
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB617BB03;
	Wed, 10 Apr 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S6kmenwX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OnS8cqlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5B537168;
	Wed, 10 Apr 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768355; cv=fail; b=feCdbepCOQUd/LvV9uj0F1oc9hZslMFL6pnJRR05ZPh9lka6IdkxLd6++b/KGhvJpMskQZW42tE/LmZP1BElPdpoqrZdybRThkcTy9GpNyBePqpv6czRgY7nJ1VoOsgGx0ClcgF0vH7DVkhcQuDMpUCf/w3fR3OafGmuAWeRTzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768355; c=relaxed/simple;
	bh=gPjZ1v4buEhN5W0ewIwnhIaZ2GS1yV3mvmBN2Ull7qE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ajXv/VWa/FvPWAxc4SheG1xZ0Et+uQto/rr6xYF/3+WujZRAjOlJi+6RdB46TLS8EPIETYJXHmKuIpIi65BGzQemvDUCSn6E0w/AIrhBBAhn4AuC+CRve4q5LZl/pNXs5Fp1BhAhs7Y7QLHtiNwJ/unYznkxOR2wSBYYuJOmOMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S6kmenwX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OnS8cqlV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGDjLq020552;
	Wed, 10 Apr 2024 16:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ivdBKRhvna1Rt27vfDaJ4OB6HUv+B5S8FSD5xPwN+L0=;
 b=S6kmenwXWVutMc7ticyNn+07zZ4NHWLlgs2gad45sWorwKsweiJt2gycQfEEkImEQsMP
 RQRILBHmkAYH7bgcLZ6g6MG4MxJbXIjPXqbDXl39pdy0IrZSllciogsI5d4tnX32mPfA
 cNS9RxmX9CyLrP77dGlwt5aNEP0K3wTqnMpHx/0rGvYTrfYt2M/rxNDTxbJnu4qKk3cC
 lznDi6cBUH/8YJlrK6Z3gUEHUuJeRxWmMK6BdtquG9DxIbcEl///5zDlKDbSF2lpuEkJ
 eptqGzeAuPJDfHbisPAbol//gvefPzetUyZ1Y7ogmk8QWdQPtiqBeddlU9fiTsvOe24Z Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaw027xwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 16:59:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43AGUiU2032537;
	Wed, 10 Apr 2024 16:59:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu901xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Apr 2024 16:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQHtmD7L2RSuc6Qdp16bQUsJB48LcrDEUzjKx1MryKD9nIciha6YPEOW3dLE9UiaV0jCxemN4zX5uSNW/cLXsH0/EoQi9ZHs3VlX1Gsbs2WYGb38MJzOU9DBXHTbrMMsOvQLPV39MlAfIV9MN5xkpna83uf5yVC7jMa2l+tslJa/5W6ALdrrlZ8hNzVmxgFAVQYsCUxU/50ohQikDpJeNW+kNf/yuRB6jCX2KuHqtv40LwTUn5UpW7/yNmolK4rHX7K1Vn4Nj6jPZoFb2vaL7/QzrkIPm3pLaN7WER+KF5PcDPc13LHtQOw3FovX//e1Rdmlo7k/JgF0dNi8WsMLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivdBKRhvna1Rt27vfDaJ4OB6HUv+B5S8FSD5xPwN+L0=;
 b=XOl9K2IrfJT31/UOcGyiYn2B0XsYvvjdeht455s1QHf5fvmi2cmfavfs4vW4evPAvY+CVsiKrfy+Q89wHKdtY4MNG85AWHwJGOZDSn2fFO3zufcaBQlPG2QNkJmzrES0zd0Kf0lj6H0gg4pSYN14+cZz0ylcJ6PUltA6DOw24gA4DA7yOCnuqGu8/dJtnql1HMPPnlHUSO+Stn+YnH9jTVWpqNAOMCbs9Klg0+KwgDs+oFiYj6NlE/RwVjVMoxW4jWKuy/V1Xm0nCiIfwGNdY3tkdeG2xxneYqsoIZygqbAEfCY2ulLc39qnVWIgKF0za9CoX4uFMihQ+YSAyE30pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivdBKRhvna1Rt27vfDaJ4OB6HUv+B5S8FSD5xPwN+L0=;
 b=OnS8cqlVlrrxaHrJVDBGi/9ui9SnpzvNU5IxwLDYndrU5ysOXAPo31JCN8xY2Iwl4G34kHG69kzUtelmDjFrRp3MLYzbR1UWIqGuMLLmCGBga0GmnBFMDLqYdev7q3q15uhofhtIq2yCW/JWesCtLo0Y4zzMr0n/oj9yxMI7HSo=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB4503.namprd10.prod.outlook.com (2603:10b6:510:3a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 16:58:59 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1bae:2a6c:1de2:3856]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::1bae:2a6c:1de2:3856%6]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:58:59 +0000
Message-ID: <f4f7c644-b229-486b-973b-97c55dac334f@oracle.com>
Date: Wed, 10 Apr 2024 11:58:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH] jfs: reserve the header and use freelist
 from second
To: Edward Adam Davis <eadavis@qq.com>,
        syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
References: <000000000000ea6cba0615a3f177@google.com>
 <tencent_59925DB41938CFAC0DDEA5A40DB592425D07@qq.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <tencent_59925DB41938CFAC0DDEA5A40DB592425D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::6) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB4503:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P2/aODOVMScnkuogJnWKl4D8VOGhp1SMWmYhkcUzBqhWOK0KFokG3DTm0T/RbILCGaCXAVdWIijVg5tRHm4jANfAlOV0EqqIyCj6PuVnH/FKD2vlS10OFQLrwn1qcPThME/kbTI4ccc4XAY1QmM8vofLnEIGyGBZCl5EleULF0Qyj5xFKT267Mf3hTHVM9Os6OivkhlpfRqxgU/s51D8fSL/yxmRezqH4EsRlEuQX+f0TumO4/mNNQ7BvKxKXUvp8Pdm0rby/p9uY8gP5eKocmKhlqgEXX+oEv1fhV4YvEpRXwwZa0kYxGEUoRnNR31uZ0svuG+lLP9y5edZAPPElgYxP5Idpklc/gWYkkjuityrbbdCLKUw5DLDQ8DSoVbPHr8lotOnHQCsXstdZRJzRvb7YI2l3wTlgRt0k7j6ddPGlGkmehnOQWOen1qjTgehRcXHDw4DUXg9P4kGSluDQ2aN0Hf15or9evAjvOci1oHgXJQB1iALHEPeohrHClPf0iUUfQHg/IYPeRx8YrriQCQ5BcMBLygf9HWTi5400JFtUz9PoKL//7x2n/GY3nvrJz4D1t8Q707ItmjBlVqlKo1mLbny+6eor7BepVV5y7PcsyZ4cFeWXFNMVGMjLy2HYkdJHQ7EYKjuBjYx7a3LJVOa8tRXFp0N+Kv8fnBdjRE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODZZM1hJSkw5ZEJzd1BwQ0lLMzBEVjh2ZHZWU2c4cy9WUysrR1lBNWpCbmZS?=
 =?utf-8?B?Y1dCMzd6cEllc0U0M0JwTy9VMlJycEMyT3BFMy9BaVFLMndBK0Y4T2tZa1Ri?=
 =?utf-8?B?QVNmZE9GOHVRNytwditHcmk5dEdJVmNSTytzclA1dzFtd3ZVa05neGVYL1lq?=
 =?utf-8?B?d0FzRFQ4ZzNHVGYrTVd6ckNCS3N0REJ6dzQvamxUTnE5ZHdYTTJTa21vKzl1?=
 =?utf-8?B?TkIxY0l2bHFua2RMSnErQXFER3FaTnd3L2ZYWkRYRHBvQXhCRlRmZk1URHRl?=
 =?utf-8?B?ODYyOU9iNmp1d25IaEtNY0FQMloyOXdET0RYa0NIWlAyYTNGZ0lzSzQ3MHJV?=
 =?utf-8?B?TmQrTlBMUWt2SkFXU205RFR5U2pPUU9peGJhbkhObi9ab1FWRXNLVUJiS2Fj?=
 =?utf-8?B?N2pDNEIrQ1ZneWRiTlVTRzUrQlo4OHBtOHRZWHUzcGFoOHNOVlV1R1pzYkxh?=
 =?utf-8?B?RnFseFVrRWZYOUtDbk1yZTZwcjlUV2RkVjhRdlNZYXU5d3VER0NPdEN2anc1?=
 =?utf-8?B?ZjFOV1N4bU84SWxtWkpsWmJnOTlHZi85RGlyTS83L3VNa2NlTUFmTFRSU1Qy?=
 =?utf-8?B?K20vWTdNYURxTU5HUk9pUFh3aXNuTTNhK1Z5RVhJOENzOTNiL0YwRWJ3S3A4?=
 =?utf-8?B?QjZlbU53bG44cGVRUXd1cjRHWjNkSlhtNHplbWpQM2sydVVFOHA5VXBzeXhj?=
 =?utf-8?B?akNtaFJmbm0xL251eFdVOFhMZlo0RWllbUJSdkhwcEx6VlZRN3QxdDFSRVBV?=
 =?utf-8?B?RjNmMjc5R2o4MkExdUlDOTZwNEdwNXBNNFVCYWhzY3ovRG5nbk5jMVFHbnBu?=
 =?utf-8?B?OHNUOVZxTHduTmd0cUN6R0hUTkxoU09wa256ZXJIRFJITEVSaG1ma1c3S3FB?=
 =?utf-8?B?enFwUjJWWlQyQjBhUER0YWNTcEEvUUFtbmhTNHBJV0kraXNIZDJYalVjUnB4?=
 =?utf-8?B?UGZzbmFsZ0sybllIQmFxa21jSTUrQXl0NnJzVkoxdEs1QlBQUDY1VDNQVnIy?=
 =?utf-8?B?ZEplUzROYlNDTVIwVVoxSUx6WE1FMU51TnR2NndpdGFaaDZ6d2VNd05acjdD?=
 =?utf-8?B?ODQ2THkwZWFWZTlxVHJsRXVnbzJyS3QrWTQ5bk5NaVRpY0JJYWlORDhEUlZ1?=
 =?utf-8?B?aGowdjBDdk1sQy9ON0ZVbXhnMUltb29oY1g3bTdxWlVPOHh3dHdwZ2tlcnFG?=
 =?utf-8?B?SmxoTFljSVhnZmREU3dRMHFhbE5PMk05Wm9WS05BbkJBNDYxL2Ztdkt6UGcw?=
 =?utf-8?B?K0tlZDdnQzk2U1h4R3I2SDUyd3l0dlhMenVQRmNHckJSemI4NVZLdW1EMnFX?=
 =?utf-8?B?YnljTnpOSVErL1JmczVoNlNhcXJtNHFrdUYrMU1uZXpOb2o0bmNoL3NDeE5H?=
 =?utf-8?B?dGtpRFZSeEFqV082eVJiKzN6SVlMUUlBRDhCYkJkd1lIZTRxSjMySndIMWU5?=
 =?utf-8?B?cUxxbENuM2RLMkMxaS9BUjJ5eDJUNEgrYXVqM1BFZlNkWlB3QnpTdVFERHhR?=
 =?utf-8?B?dkR2bS9VVXJlQXhIOFAvbnpxejZ6aFBzdnJQUkZQRjh4U1pPc0luTFlybnlr?=
 =?utf-8?B?MzIzbVQ1b0RVd0ZCQVM1dGhCcDV6T2xQdjJhVlJPV1R3OWt0UDd1MTRJVGpW?=
 =?utf-8?B?YnI1SlpGVEw3U3R0OHN5MUY5WG16Y1R6OTBVeFJibENuL3ovWUhEWW5ubStF?=
 =?utf-8?B?eWhTRzJ6WEs2N2dFSXk3OFJOTVNXVFVNWUMwdWlPNU54Z21UbWxnTHZpVTdT?=
 =?utf-8?B?WVNRaHJaQTh1cHl0dkx6RklRbTBoVUhhaklacm43NysxeCtvaW55ZjJHNjEy?=
 =?utf-8?B?a3JaMnkrSkU1Uk83Y1hvZTB2NElZNG1JRlF3aFpuQXlYaWxaYmJVUU9BNWhn?=
 =?utf-8?B?UkNXM1d4dUNGQjNrUGtpNGdJQ1U3RzVYUEtXWTkveC9jc1I0NThScllBcnN0?=
 =?utf-8?B?RUhESDB6NGJuVVlvbWJJUTQvdng5bE9HcnpyNzdCNjZGZVNDaG1VQks1amNo?=
 =?utf-8?B?ZlVCcEpTcGkxanFlNTJPck12K0M3Y0lrMm1Zc3J5bk9XdTYxeHI3elJ0UlBR?=
 =?utf-8?B?M1dwRUdSbFdVOEVBQUJHakJkbWVjcllydGRxUnJFVnM3RTNYY2dRdURmRzJQ?=
 =?utf-8?B?T05rSHpvangvUlJoV0VKNXZUWG41QjRSK0NyRjlLajJueGVNSWhKcEdSdTJ6?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YrE2l+4NBKC0kz1WV753sA3RjNdH/dGwbQ1ZlB8jqYsz8Vr/0NVyc8kn+FLH0Dr38R7UUmfWrM54PG5f8wiAO/icxkzJu1vGDCLknbsi09WQ07LKNo4Zx24EwCe3RRUNyWzpdYv8BdCy7pfUFy71kwWL/Gn17cPNR1L7dgFjc908jgNTAWMiUsGu7DzA4DJ+3voyTCd+QpU/LVzXsfH6dQYqR7K6W/hILnVlRH9+ZtkS10jcebX3vH2g7t4+XliwZGT8XHrxhgoDZDKQJoB8cyFlUULiwhwOjEBI6C30S/nG2CAM6DHgY+lDJRVo/3PDHaAdPOGYJAs6nc/Kjrzkgo40tHFIH/5rGyEvmN3zDjR7FMc4QvTaqvjjXgwVFoIbvIpJ0QLXymnlp6ixEY85tB3k9nJq+/BoHxTMl8dxp843rbUJlV7kg7Gx8DNeINJYzZfp1dpPr0Cfn8dLIDoGpMdw9dYvLuFr0l+BrK2k+6B6gAlnIrX0N6AgXYSqbpeYNrWimqkd2/n9gydotHW4chu1DGPJl5kppKx75/oGtD+zekumqqWKE6SiWvlyhYCxwdSi1p17iFddxWKgwugY1zjEJgz1rNxZdRL5DjP6WLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a29c12-dcd7-49ba-d678-08dc597f83f7
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:58:59.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k68IvA9lii2k41St6FUpQNXHetarBDR1W3nH/NyFQeGsoyLvNg9qcdxLKcI04RhmNc7Y1fVVunJkyNHS0YydwyJ32x/SO2zgbeJdE1Cq+tk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404100125
X-Proofpoint-ORIG-GUID: 7SclnFjqarE2m66dyDr_Ijf91JKzlkhl
X-Proofpoint-GUID: 7SclnFjqarE2m66dyDr_Ijf91JKzlkhl

On 4/10/24 2:05AM, Edward Adam Davis via Jfs-discussion wrote:
> [syzbot reported]
> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 5061 Comm: syz-executor404 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> RIP: 0010:dtInsertEntry+0xd0c/0x1780 fs/jfs/jfs_dtree.c:3713
> ...
> [Analyze]
> When the pointer h has the same value as p, after writing name in UniStrncpy_to_le(),
> p->header.flag will be cleared.
> This will cause the previously true judgment "p->header.flag & BT-LEAF" to change
> to no after writing the name operation, this leads to entering an incorrect branch
> and accessing the uninitialized object ih when judging this condition for the
> second time.
> [Fix]
> When allocating slots from the freelist, we start from the second one to preserve
> the header of p from being incorrectly modified.

The freelist is simply corrupted. It should never be set to 0. We cannot 
assume that slot[1] is on the free list. Probably the best we can do is 
to add more sanity checking to the freelist value, and/or any slot's 
next & prev value. That could potentially involve a lot more checks. 
I've been accepting patches here and there for specific syzbot failures, 
but any comprehensive sanity checking of every data structure would be a 
huge effort.

What makes a fix a little more difficult is that dtInsertEntry returns 
void and it would be difficult to gracefully recover. One could change 
it to return an error and have all the callers check that. But I'm 
afraid, just using a valid slot number would only lead to further data 
corruption.

Thanks,
Shaggy

> 
> Reported-by: syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/jfs/jfs_dtree.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
> index 031d8f570f58..deb2a5cc78d8 100644
> --- a/fs/jfs/jfs_dtree.c
> +++ b/fs/jfs/jfs_dtree.c
> @@ -3618,7 +3618,8 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
>   	kname = key->name;
>   
>   	/* allocate a free slot */
> -	hsi = fsi = p->header.freelist;
> +	hsi = fsi = p->header.freelist = p->header.freelist == 0 ?
> +		1 : p->header.freelist;
>   	h = &p->slot[fsi];
>   	p->header.freelist = h->next;
>   	--p->header.freecnt;

