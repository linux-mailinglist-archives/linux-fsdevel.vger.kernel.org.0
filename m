Return-Path: <linux-fsdevel+bounces-11696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687DC8560FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 12:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7432903C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5212B15E;
	Thu, 15 Feb 2024 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XIycMjcm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yKta1aky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C6127B6D;
	Thu, 15 Feb 2024 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707995346; cv=fail; b=AGXPDZyHlG9ieNgwgYi9186vf2HOxzIunRjkzZyJki5kfD3s8LlFJhRt3baCTNnZ/EzFeBwnsT0ofoSZXSbzDFD0Pq1Am20uTCrl3XDs8xrELo4aYk5fXP/7z8mmqPrpboz8UHursxmDh7wcmZT2GmO1w95nIKN01G945EN4ZPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707995346; c=relaxed/simple;
	bh=DNqdyqei5l6xuDJG7CQhT+VMHPPgw8q0O24uN6y9urc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OAS52oAahOLjtOtl0VP3NStMlLDSqDxHSaSQrIEht106+hltlqWaHcq8k2GUCdPW8FROM7vAECP2HkQ+CJufC18GQc14agLzmywO2FA1vwDk74iWj0Od8LQEv01KFLxv7hzIkFeNK6ztLksKZjczJrkefsEtWvJdUFvdgkrNuXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XIycMjcm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yKta1aky; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F6igCo018109;
	Thu, 15 Feb 2024 11:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cHANw+pONghhRSkL/qHZwBFBtNyU511T2IX/VVZ9GoM=;
 b=XIycMjcm9nvst48S5rsQK8zH965RvJzTx9V9N9zskfigpDXWVt/FqJ1mw4e9eSbzCxza
 RaTiwLXJeZVdKd2081Uq9peexfeVLJezz4cYC0i/twTrzXAehJvsC3ADAi/ol0CI33TT
 ZPmbAIdvgcozvzhgcKuDeL4CdXq6kYG/H20UoVJ+GQJDq/UsiDT6aWHAAVKOrs+r5kKE
 PIjVScCEatFidZisHGgddpz8EwFRyWb5WE+KFLrFX1Pd9+2O5RjFUGVLJ0Y/n04/6pcP
 s5lgMPoBu7NsRTFRmUCroMfPbJ45r5kqU2yhMgwoyXT6madMvG3AHt+u3ieLExQ68vj1 Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f02259-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 11:08:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FAtR2G015066;
	Thu, 15 Feb 2024 11:08:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka2v8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 11:08:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZV9EFzddLxN+PQZ9phnYmsowAy1TWC39D+7eiqv/PqwHH1qLk1zuZ2FRXC48Ho7dm0f/BeM6CqZR94clbCu1hqvmr/IKAoy5pNXRxL7iDb4DYEEhIniPfofgankfF80UPpTn4gkuHcymRaZTYDFADs4gRAZnsbUHEoHFNaTqBTvTQOG4ZOjWX5bqW75TuLpQxLQFybQkNtHEEuHTQdiIdfjNHJqbgdsMk4KmmbUlnKWzbfg8KNbNWOgEehRIKdSd+kR6YgeeL9gjlE0glSQvUnNg81nPFhE0J4lu6Akkb2beZEFllDkcbo7cek/WO0YyIRmbEKrcVZAzcMZPGbwhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHANw+pONghhRSkL/qHZwBFBtNyU511T2IX/VVZ9GoM=;
 b=BpIi62nKe/VtgCsWbYYXsdR/2h6Ki5JsgF7XIQl8GQHBHKWBh5P4DHeMNA5hxGxK0ZKhnDyn9ICOrYj9q5X1W6eCswbMOelboE0kx4mAxBWLfnpqie8S0p1oMq5akgGpOPRuL49Wsjz2vAg7rwhcI9MaGR/fc+GEtykNLlM9VHrTX+kfpHko4Z8HTIDUT9NTgYuiIePCIH/UqYE0KMwllh12ntc9HU68xihnU6gc31QVSwn1Lri80b7jiQUmpWvJ8eTCPQKyVDKZqIF0Lnl9AIiRixMl656HlbZYNA07uwWrHQqYbY5ncalkSFwMDLFg08rM93rHYJpodvc5ytZbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHANw+pONghhRSkL/qHZwBFBtNyU511T2IX/VVZ9GoM=;
 b=yKta1akySv9hDA5udZ0WJzttpdQNzUJGaiZRWZm/umuA/raj+gxoN+kzXsTfFvXAtVmictY8vNfXqD/44ypjFOTwmAKuRls1iAFZFz2Sg6jzfCEL5mg92XNrv7ikgG/nx8N1x8gKiu4RjiG3sy3oqVEV8yNPOswoHz6DfISkQ+c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6276.namprd10.prod.outlook.com (2603:10b6:510:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.44; Thu, 15 Feb
 2024 11:08:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 11:08:44 +0000
Message-ID: <8f83e1b3-c9d9-4be2-9c95-249e1b1bd898@oracle.com>
Date: Thu, 15 Feb 2024 11:08:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: iomap: Atomic write support
From: John Garry <john.g.garry@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-2-john.g.garry@oracle.com>
 <20240202172513.GZ6226@frogsfrogsfrogs>
 <2f91a71e-413b-47b6-8bc9-a60c86ed6f6b@oracle.com>
 <20240213065518.GA23539@lst.de>
 <cf2e7d4b-9ad0-4013-8e5a-48047c588411@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <cf2e7d4b-9ad0-4013-8e5a-48047c588411@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b6edc7-6611-406f-9742-08dc2e167964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HhJzn1VYNn+NepwoAPuMGWJF6fCKctINo7nQ7jqoVFP8XQTQuBA3NxNZgwHjJceTelXN+1WZHLSVfH6U638irdhTTh8gBRgDxF78nUdl9cXQkRiKFoZk+ZaokFCApG9TJ7d21ZPArtDo4LdzaF0kPEJ4E5DLk0FZEyu7vSNhMEqx3fW6nACWVNA3tQa4Ul4kPfdyfIDHpOsUTKQ7M5vJrSClrG6Dm00KSTFBi8KMdUzXJMr5EOsGy4KD9l90CHDNZTvR8pYj7R6cjWo+SnMcTcstylAGgs1//oJENbP4p7zv5/T3+WBF/acD9DKYJ+uubenLFbEklc64mJAG+QSrGNo+jilu7xhoeXDZsAxRPFMBYuf+uDX3XwEs2wwGXf9IJ56y7OoiKghYItY2HsEHSkR7l7Hbj53Rgvd4TEj75zQ4HtypefwZgKp6dRmsS2iSNZsIkDoeRmktqDgU2SmNODmP5mJ3fztvRnyy1dJghEWSHp+pAcneAjMrO4EF978BKwE6etjJ0LvZ6GiqkiOwyfxfb303jO6I6um1KGElPKGaFTLvIkpx9InMIWDFA3Bq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(66476007)(66556008)(66946007)(4744005)(2906002)(8936002)(4326008)(8676002)(7416002)(6916009)(36756003)(31696002)(86362001)(38100700002)(478600001)(6506007)(316002)(36916002)(53546011)(6666004)(6486002)(6512007)(26005)(2616005)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHNPdUZ3c2NzZmJqdE42THVvMFR0cXM0WkoycnAwTnMwWmVPVkFzVUNrT3hp?=
 =?utf-8?B?eTArM01LcEZmdlNmTGVnMHo5elNlRjA0Y2ZmcUVhK081QnNQbGZQNlZQUitx?=
 =?utf-8?B?TTNtaHJ3b1ZIaExrRUpmbTRQQ00rZDJhQ3JwOFZKdmNDQzQ2Y0NMcnEzUEZ0?=
 =?utf-8?B?M1RvZDNkd1hZVzErSDZMV1loRkEvNFhPNEFIaVJQZFBBcUJPd1NJMDBpb3FU?=
 =?utf-8?B?NEw0RWY0QUNnQzNxMzNvaUFIbmRyWDNjQ3c3U2FhR0xFNFY5amF5d09DV2dB?=
 =?utf-8?B?NC9EV0lpMWpNak9rcGJXR04vK2hSUGVuWjhGU3FqTDk4ZlZZdnZ6dWx6VVRW?=
 =?utf-8?B?R29hUnRFSjE0aGsyR2NZd1Nhb3RZVHFaQU9MSDVGYUsrempSWGQ1M1dFdmYr?=
 =?utf-8?B?dzg4U2tPY3NJY1dvUEMrZkduYzB4UUQ2U2VnKy95VTNNQ3Y3NWlZZU92cFlq?=
 =?utf-8?B?YktIMGRmck1vWUlvNkhUSVlnL21uV0JVMUZ3Z3V5V3RiTDkyYlByTnRlaVRY?=
 =?utf-8?B?ZStpRm9KbklFT3I4eXZKalA2VzFJV2VqN3pseFNyMlZXcVQ4MGFKUCtyZ1NV?=
 =?utf-8?B?Ym1ZcDUzK3kwM09FWUxIT1Q4THBRbmxHQXV2dXd0bmpXc21zMEg1Z3lwMVRZ?=
 =?utf-8?B?K2txUnc5RXBvMDdGdlVwRndLTlJOVDhKN0RjM1FWL3ltUjdXS0tUbFBjUkQ5?=
 =?utf-8?B?QXg1dGVTcXJLTUdYb0ZlSitNR0dNV1JaR3J2cVZkeWRDOTNCcklUUWRaRmV5?=
 =?utf-8?B?aDVYZkc2b1VDVkhYaHBmakY3cDlsZ0VxMGwvVjNuRnMzN2trKzdKaHpmQzlO?=
 =?utf-8?B?QitLMkYvbHBuRW1oSVBlK2lUMi9TeTRoTms2dmhFZ3ZzWlc5T0hKb3B6T1VV?=
 =?utf-8?B?YjVnK2VKRGpsZ1Y4bUR6Q3JCL2lscXY2eVE4U1VDNDBZM2g5Rmt4bSsrcDFk?=
 =?utf-8?B?Sng3c3VOcXVodmx1SHd0VkVUYll6eWxsS2JHdEVsZU1JYzNwZ01ydGZIRlZT?=
 =?utf-8?B?VzRndml1TkRtWFB5UmxjWHVYd0t5MFJtcEVEaWZBWEViLzAxbWtDQjdJV2Vk?=
 =?utf-8?B?U3kvdllGRmdYNyt2MEpPSHN6N3BldWcxb2ZNV3ZDSEZxcG00Q1RuOExRRDVu?=
 =?utf-8?B?anZhdHBLMHI5VDJxZmNPdTBIYTlMcHNQUS95aDBXd092cTlMU0pNTC8wV1RZ?=
 =?utf-8?B?OFhlVU0zR3NNNWYwSVZSSTF3MUhuZVlpaGhld2ZQK0Q2SzhzeDMwcDVtWE5W?=
 =?utf-8?B?YXZCUUszS2t1eTV6ajZLakFnOC9wQXBaMENYcnIvRllNa0RJd045azlyTU02?=
 =?utf-8?B?MUZXNGx1NGhLcGM3cmkyaGZXdjB0VFgzRlZjRGNsSkpzNlU5Y0J2U3FHa2Jm?=
 =?utf-8?B?c01iU0VmcG1MUkhiVFdGNGxrUUkybko1NlFlYWlPNzdmSW81VHlLUEs3djJ6?=
 =?utf-8?B?Z0srbE9Mb25IM2pveHJ0SmhJVjBaelV4SDIxWkRJNXgvSk1pTmYxZHp0bVpv?=
 =?utf-8?B?OGRvZzYyNTJzbm1tK3JWa0tjejd4QnNlZzhyOEZBQjRwWWhDREZxbFVsdUlR?=
 =?utf-8?B?TThLOExGRmFXcWFlUTc4QkJESGdGb25UN0xrTXBFZUhXTERLYVBWQllYTVlp?=
 =?utf-8?B?ME82WVY2QzhJcmVtZktsb2lTWW56R0JvYlo5UnNqMzBJQW5JSDEveWVKdyt3?=
 =?utf-8?B?RWx4UWtvdC84YW0vRm9VMEtEQk8wb3JNQzJYakNkRmwzbjBSakIxc2dua0ZF?=
 =?utf-8?B?R2xSNHgrSjR4cmZNeDA2RFdSaml5ZEUvOXVjL1ZQbFRnait5U1pLaHB0Y1Bj?=
 =?utf-8?B?a3d5K1hOTTA1elArZlBKTXdjQkpqeDV5QTE3VGtBUzFrQldmTlVRY2hyREM2?=
 =?utf-8?B?c2NMVDIxY3pOTWZ2azdNQURNYUNhS2Z3TDFFa3V0NFJJUUYxMGVySVZJM2Nr?=
 =?utf-8?B?U2NLU3EvM1VEckxzT09RbWZiL1l2dkZqMWx1SFl5TnBTZURFN2ZIenhIL2l6?=
 =?utf-8?B?N1ovcnVPazQ0Q0RxdFBkMFg5WDZBVHV0TlpsYmRtb05JT1dpM2VCaUduMHdJ?=
 =?utf-8?B?VUdLaVo4NjkvYzZHQVkzV1dZZnYzWDdLZkpxQUdXSnZOMFlLZG5uYmprSEV2?=
 =?utf-8?B?V2Zia3BoS3JRcmVMYUtHbDRHMXVtK3lCNlRjSUM0MGFSK3dCMHZ4UFhJOUNP?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z6t+SgApPipwzZ9EMYU9X/u/PN1ZjP5c+EL02dqEBUwhGoTLolCBAfGCXjBA8Gx5krpl8N6rXAkicaFO90rIfIB54EDdvdV16gE/BYbw5Q6y3zvPx8XK/Y3leDSJmTnfX6Hhl/CY/HW9jrCXdPDyKhDyCrR1Awh1ve0orAV7Zru9PyWpJ099v2PanxosQg0vBfCk8z+UICtM98xJzP7TWLkTaK7R2uRShdmU5p1Cmp0RO09tmkQXaLA0xr3lkejdCvHw+limB8hqxS9tXkxbjpXuw0A4Ltnlxoh20Z65m0KW2RCnPOrqwot4xR2/n6Ov+iRCANEEKnHmhs3n2B2vysBnS4uou904XuZ2gj7itHFL/fXdd5ZGeEUE2viXBgv3XZwTNjxgsGi5sd1jeAAWz3XTEY7/Aaf96RYS4B193QUG/7lNqKe6L/3zaR6HENYWwPbmiblBIkzKWxAUaLQ6dXMQOE2hiyPn5xsrnXWuTfOrh82CidNl3wl26pcl9GPnIa5xRx5Sc5sgNAWVc1si6fD9OTCek6mQ4iwV6o6X+nAD5nUj1WtgHhTt5UO91aOHOZiUfZnpkKa9pUJp+HaWKHLVeeemcaMgG5jzJhABenw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b6edc7-6611-406f-9742-08dc2e167964
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 11:08:44.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2Aqtf9pREcOQi/Kefk3ss/zyYeJm431mxM5iUqC7005HjMZNkTuMa2FW0zH4qXwDSCvrJE8vlfJtPueYzB03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_10,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=882 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150088
X-Proofpoint-ORIG-GUID: T8S3fRmy1C1QVdMNRfCRuHU_b34VWude
X-Proofpoint-GUID: T8S3fRmy1C1QVdMNRfCRuHU_b34VWude

On 13/02/2024 08:20, John Garry wrote:
> On 13/02/2024 06:55, Christoph Hellwig wrote:
>> On Mon, Feb 05, 2024 at 11:29:57AM +0000, John Garry wrote:
>>>> Also, what's the meaning of REQ_OP_READ | REQ_ATOMIC?
>>> REQ_ATOMIC will be ignored for REQ_OP_READ. I'm following the same 
>>> policy
>>> as something like RWF_SYNC for a read.
>> We've been rather sloppy with these flags in the past, which isn't
>> a good thing.  Let's add proper checking for new interfaces.

How about something like this:

----8<----

-static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
+static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags, int 
type)
  {
   int kiocb_flags = 0;

...

+ if (flags & RWF_ATOMIC) {
+ 	if (type == READ)
+ 		return -EOPNOTSUPP;
+ 	if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
+ 		return -EOPNOTSUPP;
+ }
   kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
   if (flags & RWF_SYNC)
  	 kiocb_flags |= IOCB_DSYNC;

---->8----

I don't see a better place to add this check.

John

