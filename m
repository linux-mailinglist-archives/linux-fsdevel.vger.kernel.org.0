Return-Path: <linux-fsdevel+bounces-10319-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9790D849BF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDF6284FD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133432261D;
	Mon,  5 Feb 2024 13:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZFYUUC/v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AQ++EPh7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592A249FA;
	Mon,  5 Feb 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140195; cv=fail; b=r2zWV4SzbCvxDlIpwp2DoE1O2s9Hi6eZ869QuniReu27l9dxz2+dpjraSHGV1YFjZrW1rQH/Q7iRoYLfU+TRZ2iUTzt2NqxTSJBvh0ucaPTLXNnnmSNi+dK3A5xCLS85OLirJm1EFJT5T+XgpUuILiux527ZpkJET8nhh9cSbqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140195; c=relaxed/simple;
	bh=tAhjy1qDo/KTmhe5RE5gieLJgX8hBeDt9dHIiLWjxkI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsvNuprgafiymJ1dlNtuOPQLaRpsVB00ST9Uh0LOjna3y82u3x5ZBr9xge83rv5eYxZR0hG3bofHoCOMmIWf3DRc2/VIQjI0GZdYFXpLuENIolO824ByjC4TYztefbfLW8bU0POVfMDQmeX6LLeegar8vxV/nC80bJWC1SkcwI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZFYUUC/v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AQ++EPh7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415DWH81010947;
	Mon, 5 Feb 2024 13:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=v6flLN9Uhat43OcellwlvVDcKDqeu+Yt2MLS1RJmlgg=;
 b=ZFYUUC/vuH95v9VUbHm8/SLGQH27CBatSA/WICLjHHJMLURnV7BbbxTjCFD8H3RbN6pj
 O5RzUSwS3+rtjjbPCpqL2JqmHc2fGR1Flxw1YOzAURzHc93+v35m+OnVESkjINobAZLM
 Eo2OGHKTSbLkhsC/l9nFLsjiAT+qEw7G2TD/wGm9SbgHJAxfu/ThUU5AY/vtsNgApUFi
 eN6R6nYgHSMSkTyTsMGTGRQRRApZftDhEg7wd9Cz38yZG3+Ua1d/KHOuNvTuaaMeYxCx
 IEANp2emW397i9JijIPLqJVOk88OYFAY4790eyR7BN3ztSn6lMvMf+b1GydikSXsbsOF IA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbbu2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 13:36:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415DVAXO007193;
	Mon, 5 Feb 2024 13:36:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx5trpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 13:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4tTDOBKEGLmGOG4poUil32Rl5/g2Xb7yEiQwfcOetzOt24hkXPPH63/MOpuabmC6kzh/DaNm233VMnfHpnZp6nHByZcUbi++i6Tu9aJow38KhVxnuOP/OYxk5cNP/cLjzGc7y/i7k2QCsMSPcvNNuGXeV2f2rc16qO6tUHpyeDKpvvVRP0l7ZAKfzJyVnbCsq4Cvzz4Q2fhPtzXTzGYTm7PCxzHHP4fwBqB1cKfUjrLXsxGyGByhtu5zRo7LPanohG0un+5bx2w6mb5rK88NPdff+8xVN3vtCp6IFym9ESv59MNsRjOdGdtqL6ZFObTBYVxKrKY1feaN4DdHOsHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6flLN9Uhat43OcellwlvVDcKDqeu+Yt2MLS1RJmlgg=;
 b=PWohpD7Hb5YqD8S4LT+5Z5A0ARjbGhYM5qVyV5AGddQ7ALDgkLERwUlr5dkQHUG/TuzpmWjrXIxiXvCZFpJttUcXgKXKqdFXV4tg3jyfAZEIprjf/R+rVijlAwQnHQxFdVg9WWkMbQ/4cJKWoL719RYclPuTRqNB40Y9vDn3djNo8r27MYCQiBm70CiEi8cEuSFqoQIJx/rtI9H1cd56Q9Lgl/P3Eh24nGlXWf9K3ej9/6yGGQSdhoptW0U0ZS4BVEfEK/1k2BxQVgI3HBHauQbiNIDoT2nr91CysHh+YYZ0V95CnkVOvV7UDsA83MxOZy3vqJ4bX9zjmZjMrllqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6flLN9Uhat43OcellwlvVDcKDqeu+Yt2MLS1RJmlgg=;
 b=AQ++EPh77kcPQ3hPSsR6KWFcSPqeEfUxGWax+q6fvKKZO1V0H+DYeEarVHduWB1MRgdiIEtUeUD4BLHebapouYfSpkvzA8chtfAgZNea8nikO3unuC7xmOGcvmnhYYME8GJ1oiKhZTzg3m9h0Jrd/XVTKIDNFMomVR0DHPlpe1g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 13:36:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:36:08 +0000
Message-ID: <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
Date: Mon, 5 Feb 2024 13:36:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240202184758.GA6226@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0365.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: f77e0926-306b-453f-1974-08dc264f68f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rQczIg2N3OQ2lteuO4QhAkFpM/7zaVe2cHNupBQW3GoWt7+XSbfdZ27Hly7ooI/RbapFhMOYPE0KGpDswTxyB9xFpZU52hERL4+9QQNTMAUhMCVeqelNfpQ+byIVDb8c6zHzSzOxQmxpNsTEKjn47JHGIB7u5ncqXpzDOMVTT4OeVEk/40w+nchbhWKeIbVWEKGS04mIh3fad5LAUOq/YPecAwLJHFfMgPwjhysJwv310xwVdYQmQDxH5xLgZEFhWFy0zhXpX24bKhEGNrLK4WfvzHIfj1r3dCYFcmPkBhxmkJKbc/Fa7D8qxaNJIiVX0zoOqOYbGNkkRauRCi2FnA0yZydtNvd6Sr8X0Ev2yQwSNVuB70txB+Z3zUVoTZa1vobQhOn3zaV4vtjOXvHGiy9u7I16V7MqwviivKBv66tFMFcv+TcvcM+7jvbvFAevCIabXRYoSnY06DmaX5LjrqEz6jQBhB8YguRaYhcQfhtpjRvzvW46KVqwrysm3eUM5SsIt5EFZq4LAbuZsI5F7XJM/w+zn8NYZh6IOBR36mGHmHzmcgcVh+KLAe+OEBLyy11Jf6VlhD8MCif06AA7zkqexCI7kDyY1h1mb891DCBdJD1+9WES2JS277m/etVwYtnt/jP206oyaGYLkOgVHA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(26005)(31696002)(86362001)(41300700001)(7416002)(6486002)(5660300002)(2906002)(478600001)(66476007)(316002)(6916009)(66556008)(66946007)(8936002)(8676002)(4326008)(36756003)(6512007)(6506007)(36916002)(53546011)(6666004)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bitzNi8xRmJnaDlrSjBmTmZYRDIyWjRiRkt6MEZrSStMQ2hadnVWZjkreFBK?=
 =?utf-8?B?Z1lkNWNyOEFFT1hvdVpMUXdpRmZLSmNEWkJuRWlaWDlJdHZLdW92T2N4V0VT?=
 =?utf-8?B?WU8yb1V0QWdRZi8yNTZDZ0VXMk55K0o5NncwYlhabGJEdkVwTjJJQUdkeitG?=
 =?utf-8?B?TU5qNzZDU1dzNTFlRnFPMDNkUzlFRkxlYWRIY0tLR2plUGdGS05MZnc3cWtx?=
 =?utf-8?B?dTZBM3hrdHBDdDU0UFpLRXc2eEQzSHc3VUxRN1JNdTJvZitDV0RuMzVOV2J0?=
 =?utf-8?B?M1JLWkZwK2hjZ1JKYkdxdWFtVERGdUdrNDRmYkR3NzBsTVJKZ3RXZTBOcWVR?=
 =?utf-8?B?MzllMW9rRlkyYUlHSUV0UDN0Q09OQks4d3dQU29ZZ21rSlVaTmNHa2lFUHB5?=
 =?utf-8?B?V0dISGZnd3MvRXRQdkl6SjJyRitsMGNLaWsveVorMjJnQkxaQWlnQzhxV2Jm?=
 =?utf-8?B?eEhzSDQvc2czbDYxL2FhaUVvcG5ZdVZibWNuNzl0ZUluZ0RoOFBxNlIwcFhB?=
 =?utf-8?B?S0F5NjFQa1pmSW1OU1BHZEJUbnVhc3ZhcDAyK1FjUVZER0dVM3MwWjJWWGhC?=
 =?utf-8?B?K2hUVVAxZXJOQis0ZTlqdkVXRVhRVWxzQWkvdExBSzR1d1NqWVhHbDY3ZHdi?=
 =?utf-8?B?UXRIY3l3MExxSDcvS3RpcG56c3NHUTEzTjc4NVlnNkJZb0ZWenBqbXVjaFdW?=
 =?utf-8?B?UmVDYkVKR0ViL1VEbGdWNFNRTWhPcHM4SWR2cDVnWWdtMTduSlFWYVdscmFX?=
 =?utf-8?B?clRkaS96UmVmWjFpYXk5SS9tUlpjdlVKL0N3a2U2U3VZMW5DVzdnTVhkMGFI?=
 =?utf-8?B?Tnh5S0o0d1p6Y3pCd21pL0VSTGJJQ3NBM0ZLd1dEckFzNEgveTBkZnlTUzRR?=
 =?utf-8?B?bHRRWHJubzhLREFyTVVrRW1MMHJJd2ZkNnExL0R0TzY0amJlTlFFN0ZWcFNJ?=
 =?utf-8?B?ZUIyU2tpdjFzaEZQVUNDSWphQnA4L3Jhdmptc0tHbTBJRnoraGpRcVZGaG1k?=
 =?utf-8?B?NU1MczF5bEczV0FzdHhEQmttazQ0dGtDRTJrQUtGU013eHh0RUhOd2tUMk14?=
 =?utf-8?B?N1MrVmhoVExLOW8vRWlLNmtoWDlHZHMzS00yd25uN2hTYnpUc0cvNFh6bnI5?=
 =?utf-8?B?N2lZYjd6NjVHY3FGZjRZd0ttR0FJNTFMV2gvSS82KzdwejN3WTUzNTBYTXVI?=
 =?utf-8?B?cXZ0am9EN2pmZ3dZQ1Q4VnNtK2RNMkhGMlNHMVRrbmxOWFVjNTRXcGpsNWJj?=
 =?utf-8?B?dlpMQ2FTVmhWamlsbzB5ZEkwc2VzTTRRQ0xNTkFhYVRzRlQ1eXFkRE9EeE5j?=
 =?utf-8?B?MWpISTVSYmVOaVQxcmNzZjRlbGVDMnplSEhzNzdvY0FURkxoWVkzN3p4QlRF?=
 =?utf-8?B?RDlEdmg4SlZZMmQ4WkplcnFFK2NPT1BvSnlhRnIwSldpS3hjQWprekNrUkpv?=
 =?utf-8?B?WjN5VVYwNmVzNmlqd3RSNitUZzFUMlNCQVE0bW1LYlNmZFRSd3NoNlJscDNy?=
 =?utf-8?B?S29EU01BaXh4aVY0M0ZabkRUcjV5azFaVk5sbmU1N1ROcGd4TnQwbjdyRmV4?=
 =?utf-8?B?dTdSZGZ2TS9sVXlrMzVnc1o3YkVzdzJiRzZkbDA4SlhFN2RBVkY0ZnRPcWJo?=
 =?utf-8?B?RUwvTG9RdU42czRMNjZBM3VDK1Q3TXBnSXpXa2dxYVQ4ampFRTUzZHJONVdF?=
 =?utf-8?B?VEZYcDhQNlo2TDJWczl0V00wUkt1alNRMmx4STRhNjBHSzVBdUF3WnEvZllh?=
 =?utf-8?B?MzZIK2NhdDJSUTZseUFuVkQ4Q2pNc29xdGNFaDJEVG5aVmRmMXBSd1E3bjky?=
 =?utf-8?B?dVpCMjJHeDZkclZUSUc0VVBoMzdPOW5aUXVaSzlqK0tJYXNTYzFvUUwzTERq?=
 =?utf-8?B?WEpOV0lwdFlmNS92TjJOQVM1RVB0dU9kSmNVRnVLZGxJV2FVbklUN2x2SFRr?=
 =?utf-8?B?bHdSajgwSitKNWJZN21mMGhJZEVNc2VieUJWdm1PR2VhV3Fza2FWb3NMZlJQ?=
 =?utf-8?B?bGYyTjMzR2hXMWkvZmJzekdMdU14Q2ZKdFgwS2FSaXEvNnJuVVV3eUpUcWEz?=
 =?utf-8?B?dW5XZEw2K1NRSU9uS091VDl6QzR2cFZOVnFlVExHKzFkUEE3Q3pQZHJ4WWl4?=
 =?utf-8?Q?uOkSysLyIDYkQU0j1VhTQsjdq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YpJejQo8QgiCegeJpD8ayXfz2tlkYl61Wq3g60yd0Si2c19YVs6owGXs5sUZDrp4tA5LoPiP5dtA7sUEhL6dxIWdczR+CahCSxlpZJwwxnq1WhaLS6xYN9dTwgnHhxX1+BVIsWxmhlZ/8sJhLLNsdRYzuLRlOCu2lhYKcBP2HvA95pqRn7nB73Bqbx2uBiHT4KMv8Y3xBpNZ8fGcP5/PkNDAU7zquD7xYZtxS96c4GiZLFsmm20cOkeMgI9zNui5/ZD2gFec1KS+yWIiLelW+aFUWsKOfKRGhSDGLAHeKelKOrTqZAocIG4OaaIQX/2p7g24151TgzNT86Ok+rBL5TP0pZa1qv95CXWIGlgNXFdFcEj4lYkXpZa84HZVKnIFN5aX9Og2bm+ssxvBgeA0AICJnhsOQfA1lUpPfFsKePy0h2Mc1zyl91PgG6pi52zEFc3WKPHXxgKt9IH5isyzZdnCnCv1kuS4a4ZouVsi5axW95j+vpGN/6zwZGT5294PMK+HopKlYPn2EradMhz2p21GnopLaDA0/dD0JIzX1ejWTn8ETAAf9O/2sG2zEDB2KYPvqSYzLhOK9+R+ewPpKCjYuzhSU2+E+OawUzlCsTk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f77e0926-306b-453f-1974-08dc264f68f2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:36:08.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPNAo+tbJ+59fWCVhIkv2ZG1atYp2yhf+EZzwt1lzebiqITKqHLkwbvvrvnweWwJN80EpncZ2zmg2+YUX6/IpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050103
X-Proofpoint-GUID: UNK5v-WCnGAgErvVyDFFHmiBxmuBUnxx
X-Proofpoint-ORIG-GUID: UNK5v-WCnGAgErvVyDFFHmiBxmuBUnxx

On 02/02/2024 18:47, Darrick J. Wong wrote:
> On Wed, Jan 24, 2024 at 02:26:44PM +0000, John Garry wrote:
>> Ensure that when creating a mapping that we adhere to all the atomic
>> write rules.
>>
>> We check that the mapping covers the complete range of the write to ensure
>> that we'll be just creating a single mapping.
>>
>> Currently minimum granularity is the FS block size, but it should be
>> possibly to support lower in future.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>> I am setting this as an RFC as I am not sure on the change in
>> xfs_iomap_write_direct() - it gives the desired result AFAICS.
>>
>>   fs/xfs/xfs_iomap.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 18c8f168b153..758dc1c90a42 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -289,6 +289,9 @@ xfs_iomap_write_direct(
>>   		}
>>   	}
>>   
>> +	if (xfs_inode_atomicwrites(ip))
>> +		bmapi_flags = XFS_BMAPI_ZERO;
> 
> Why do we want to write zeroes to the disk if we're allocating space
> even if we're not sending an atomic write?
> 
> (This might want an explanation for why we're doing this at all -- it's
> to avoid unwritten extent conversion, which defeats hardware untorn
> writes.)

It's to handle the scenario where we have a partially written extent, 
and then try to issue an atomic write which covers the complete extent. 
In this scenario, the iomap code will issue 2x IOs, which is 
unacceptable. So we ensure that the extent is completely written 
whenever we allocate it. At least that is my idea.

> 
> I think we should support IOCB_ATOMIC when the mapping is unwritten --
> the data will land on disk in an untorn fashion, the unwritten extent
> conversion on IO completion is itself atomic, and callers still have to
> set O_DSYNC to persist anything. 

But does this work for the scenario above?

> Then we can avoid the cost of
> BMAPI_ZERO, because double-writes aren't free.

About double-writes not being free, I thought that this was acceptable 
to just have this write zero when initially allocating the extent as it 
should not add too much overhead in practice, i.e. it's one off.

> 
>> +
>>   	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
>>   			rblocks, force, &tp);
>>   	if (error)
>> @@ -812,6 +815,44 @@ xfs_direct_write_iomap_begin(
>>   	if (error)
>>   		goto out_unlock;
>>   
>> +	if (flags & IOMAP_ATOMIC) {
>> +		xfs_filblks_t unit_min_fsb, unit_max_fsb;
>> +		unsigned int unit_min, unit_max;
>> +
>> +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
>> +		unit_min_fsb = XFS_B_TO_FSBT(mp, unit_min);
>> +		unit_max_fsb = XFS_B_TO_FSBT(mp, unit_max);
>> +
>> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
>> +			error = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +
>> +		if ((offset & mp->m_blockmask) ||
>> +		    (length & mp->m_blockmask)) {
>> +			error = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +
>> +		if (imap.br_blockcount == unit_min_fsb ||
>> +		    imap.br_blockcount == unit_max_fsb) {
>> +			/* ok if exactly min or max */
>> +		} else if (imap.br_blockcount < unit_min_fsb ||
>> +			   imap.br_blockcount > unit_max_fsb) {
>> +			error = -EINVAL;
>> +			goto out_unlock;
>> +		} else if (!is_power_of_2(imap.br_blockcount)) {
>> +			error = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +
>> +		if (imap.br_startoff &&
>> +		    imap.br_startoff & (imap.br_blockcount - 1)) {
> 
> Not sure why we care about the file position, it's br_startblock that
> gets passed into the bio, not br_startoff.

We just want to ensure that the length of the write is valid w.r.t. to 
the offset within the extent, and br_startoff would be the offset within 
the aligned extent.

> 
> I'm also still not convinced that any of this validation is useful here.
> The block device stack underneath the filesystem can change at any time
> without any particular notice to the fs, so the only way to find out if
> the proposed IO would meet the alignment constraints is to submit_bio
> and see what happens.

I am not sure what submit_bio() would do differently. If the block 
device is changing underneath the block layer, then there is where these 
things need to be checked.

> 
> (The "one bio per untorn write request" thing in the direct-io.c patch
> sound sane to me though.)
> 

ok

Thanks,
John

