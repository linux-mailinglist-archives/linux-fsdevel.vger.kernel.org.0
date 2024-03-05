Return-Path: <linux-fsdevel+bounces-13647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F187264C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 19:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826EE1F27860
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F518038;
	Tue,  5 Mar 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gOCKkhhD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tkJY8wqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14717BAB;
	Tue,  5 Mar 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662143; cv=fail; b=kmguqhkmkDBwPfamd3AiR6qh6KufYCsK/7Mz9LPfhpyq2UM3655A5ETJP5sX6q2bYbCltW1C6UrHX2TC+Tb43oaAx2xnoNl7DXS2ZlkW5QAX2cs+IDFeVdbM7KcerEN9fna/1q9IQUKcAkNqhHxrlBME46E0scuh/CheSDaO8jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662143; c=relaxed/simple;
	bh=KSA/Ntoqe9LyoNO4N8fS2tE7NAxmstwOVR1F5hHeSmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1oBm/JU+SbJOTm4QzoQsnNz+oovJm3BPcgG0KAxxMSqHt9gwxQQZ5YMarPFcs04GfPC09iotrycMRWYuNZF6GDzhIR71Fpf2DSuje3B5mHcjhqM5E0KlDvsobmM2a1MTmQOS9zOjNEaiH/K8rghXs6k61UdHJtiz7PxCFBL3lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gOCKkhhD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tkJY8wqQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425G1LjY012579;
	Tue, 5 Mar 2024 18:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=KSA/Ntoqe9LyoNO4N8fS2tE7NAxmstwOVR1F5hHeSmE=;
 b=gOCKkhhDxWT3B2pmv2LdBXda+1kvASIwgswv70JoGuJV6eT1VIEXcingTu4X3IcxAjKc
 ZxYFjhCM5G52/Y8S4cKpEemUHBRtRPSwW0R4+xQFN7qwgVNQw6RyawsD1vExASwz6tX0
 WL3Pd+PNnfiJNe4fdch8WqsDLInP4ABXij4UrntyiZJDugHha2BrRezj0GmPMnUTpQNi
 jxEH1JObGqO5lx86orO8Y8UTVTD0mnTpNc7J7WEJyGnnTw4ly2v1Vzp3hMp/zyGQNot8
 tGl95KyPVwo9C48pPrwwd4LCi7UEJhs9u/u3zD5ezdgURyFQ/R5+QNVKf1oNqznRx/Aw UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0bev83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 18:08:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425Hmf2b016004;
	Tue, 5 Mar 2024 18:08:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj899w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 18:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUQZmtHfVTqA+cAHjzIGzsw/mDi39119Ma4aW9k9aS8tPFaLkDQs/Z/qf0L1NPgcQAfXkGOD58S/GXD4DXw4aH3Xpb5hmUlzzFBNnSHE2qADMvYJWpvCoV2M07HDPuRhm/SHj4YPEXsnWgRjAOZbPGwnoxGGaBQjXsUYFMBzhmyStBgFNMq8sD3ZjIKj0ftrAH+W5WjOQyFy0uNM7gl215TXtjECXsQNe7o1YfznlcwwLaJyvNW76hMgX61SkDVO4Dbe17ipHAdxg5P8vHl+s+pJCs5JwunhZFfJxP3lDqa4sbJxb0mb1Jdj9FwikEL2YyP4GUairOuboUhnbBvKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSA/Ntoqe9LyoNO4N8fS2tE7NAxmstwOVR1F5hHeSmE=;
 b=Dvk/xbCUY0WCkBke9khmXDwWkzAIxysW3t8OUMhEyGOMAH9bNvxaSChTeSjEr2+ITjRoKiCZXivYjSNb4fuCIzTCOR6+7D25kH/IDrTkPNoGuZbm9/PsIQfSrQj5UWbVHpRnqUtzG/eGHnAV7SLC9HXBKAn6YIAi3ijOfXXkzaMN5piASI5ledbpCFTkjrB7v0q54g+2SSSqzTdz8lf3JU3/YqfpTxmXYWHTuDbrDisCpc0WkNVWfzNF/M2VVNbLIHoU/M5wlUFaN09NvWBdSOlefXCfHyUChc/QL6VJgRPamiTyjo86WWfI2iiyecJtcM2UKOvGjG3uwIzclmYe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSA/Ntoqe9LyoNO4N8fS2tE7NAxmstwOVR1F5hHeSmE=;
 b=tkJY8wqQRmL9BrCMDWznyah+4rfOnHD9RjaD2QopZQiZ44uNa+RVgk3u+Hy5p33x/RRBqgfp0ZHYKn8s1yUNWXcDcEUeYqGy8cBJZdKLQaycI3N/l3HebR334XdUsFuBPmhn/P51JxfMwU7aJLw2NS4P4jDhzuEqmRJkPrgGaaQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6242.namprd10.prod.outlook.com (2603:10b6:208:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 18:08:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 18:08:53 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Dominique Martinet <asmadeus@codewreck.org>
CC: Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov
	<lucho@ionkov.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Subject: Re: 9p KASAN splat
Thread-Topic: 9p KASAN splat
Thread-Index: AQHablmA13qhcWhJA0SMUXVJZjmp/LEoRpIAgAEtCgA=
Date: Tue, 5 Mar 2024 18:08:53 +0000
Message-ID: <504E0570-C4D2-4BE4-8E4B-D6AD86769734@oracle.com>
References: <D56DE98B-F6F1-4B38-A736-20B7E8B247FE@oracle.com>
 <ZeZjInbYNkpLPPkz@codewreck.org>
In-Reply-To: <ZeZjInbYNkpLPPkz@codewreck.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6242:EE_
x-ms-office365-filtering-correlation-id: b9416d55-477a-4ee1-3d7d-08dc3d3f513c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 HOXhlWyWWS0YnKM0rPYnCzJcs6pT7Uq2tehe12GXvf3yjeA9ZHoLpNY5IjW1rrbH+I42GqLMtYRJmUjlh44xbmYzMgMaJCqwFMuMdeCNqjfOOYBeUXy3OQBwMqBoHj8Tu53JZL6wvpbDuOuFbGq3F64avdDkvAAi1XRza07+4R7M69xW4FdMVRJSnZj7jSFXCgEk1yYi8o993dr+9rjprGofPiAj3UvtN4AtjKgKh70LtdThA1sENl0YHcO8NxRdpeJVNqZ+eVTHOJ1e21SHKji7kcK0vmn1YHrRwNgSaPpdpv6/74ggkbYon3JHUV7pQvstDD2PINc4jPeeerg5kwDcyZbcSfNWs79jXMuk9VvFFyhQxRKRu38G6ULfZ86sbwpx3SSV2EMpf8YDXkirVZchhT2ivRapd/IHxeQxxU+MISPXasJFjq9jwL1ukn1hrLhPEJgp4sM6hxR9QaOmPlBzS7LiT6XqkOn2rPJWtrn+WX4ORaNRlce0HKZZKQqBEGpjknpAlGB5nt4d8DJikfyy8KJRvnSoKighbUcLtGJQsbnhSPP9svEOOeWM4D143A8EWEYyhMswEFA4fGn2T8r0P10arhDumN7nHmuQ8r601vqikw+W7o/Ingau8dhtEkqTCcd2o2CrMNFqTNIQDxNurEfXCbvRpnhZAlbL+RA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MUhZTjhhNGlmSnc1UHdnQUFDamVsb2ZHdWdUamFaMUpiWmpjQ1U5QTMxUldF?=
 =?utf-8?B?MkZQWUprUmVIR3RRbUduV25iQmJBMXE2M2loeTFldkNYN25adWJTSndLQXpO?=
 =?utf-8?B?aXVybU9RNlllYVdOYkt3VWw4a3N0aTRXSGtqZE9lNVJrOWNYUWp3LzJTS2Zy?=
 =?utf-8?B?WnVaNjNXSHZIRk5qRENjbGxTTGI5bHh3YmEwV2xpU3RmdnB3K2pEcU1GenVY?=
 =?utf-8?B?ZHdYY1hISzNzdnE5L0x6bVJWZVQwMGFqOFZXQmUzS0dzM0s4RmJxWWk5d2xw?=
 =?utf-8?B?aTVBRElkSGEzRmxGVDk0NG53RTcvUnMxYXFTeU5wQktEdkhCSFVsdzZ5bUhn?=
 =?utf-8?B?VFArek1lMXN0S0FOWklab0ZIY0lnYkNOZ04vRXRpNWZRZG1RMlRRekRtdjB2?=
 =?utf-8?B?d3hOS05ud0ZZYndCS0NuUENWb0IrSFpPSlBJdzJNeXNYRW9TZ1R5cGdjOURv?=
 =?utf-8?B?NUxYbm1uZGZMZUVRaG45OUtKR1B5WlpRVjFDUSt1U0lOQkc2S2xSYUtRSWVF?=
 =?utf-8?B?Rlk3TGJRa3VURnlBaG54VGEyUmhDYlZ5SVhUcllRc044M2U4eE9LS2E0Tng2?=
 =?utf-8?B?b3QveGxsUXF4b0VVTHp6dkNTSDErRk9hbDhES0pxWHUxdHlSa2VaWmNVUGFI?=
 =?utf-8?B?Tk1PazVraVdZcUJhckFqTXY3cTVUUHUvYnQvVlUvSWdHS0VCNmJwV2lFUFk3?=
 =?utf-8?B?TkdxbzRMd3dvbHU2TkJBeDlaZXJzeHM2clhiaE1xS3pvaWlhZU4xZWdTOXo3?=
 =?utf-8?B?ZE0vZUZhUzROTVFqZnRZcjRFQ3BwSWFEZGgvQ3owNFlOZXFxZXFzdFB0R1Vt?=
 =?utf-8?B?amZiTThXUWFTc25SRmNFSHBJekoxV0VQTUJxRjRJdjdoVk44dDNmcHpiZXJo?=
 =?utf-8?B?cTlhSmRVajJmMXBtUUJOc0h2d3pLZUd5dTZvc3lqV0IvaTJydHBXcEl3R3gy?=
 =?utf-8?B?bVl6YVhqQTI2VWM1SGFxcWdyU0MzLzVUU2ZXeHl0WXgzM2ZaRzZRVEM2eit6?=
 =?utf-8?B?cEE3TTJZTTBIRFUxOFVaQXp0Q0FaNm5hMDNuMHdweEhsbFQ2OWFtbzdmMFBK?=
 =?utf-8?B?R2FieWJWcjFvUVpTM0piRzBCSmc2TVR2NUxwTEdtRmJNUmcyM3hNVk1iTDdG?=
 =?utf-8?B?bHY0SDFBTmxlUlRtUjY1Z1JxUG0xY1JSMmd0eTVjTzAzT3B5V3lJR1pRZzBz?=
 =?utf-8?B?QlpFdWxFaU1KcHBGOWx0b2hyM014Q2dDeXFFWmJHZGEvVlZNb0x3QWZDTTZj?=
 =?utf-8?B?NmxKYWpSR2JWb1F0TUpRMU04VEhpbC9ZREFtVHlMSjZCbVpoQ2VtVmQ1WTV6?=
 =?utf-8?B?a282Ri8zdmNUOUtXRzg3QTVBM2k3LysyaHE4VFlsSExGVFlFNGRacnFNNks1?=
 =?utf-8?B?L3AyYm9BTjltR0l5RlJqa0FUWUFsUXV1cW1jYWxaNXFrNXlJTHVFRWF0Sy8y?=
 =?utf-8?B?NnlLMUNxNzBOK0JYZU9wUTJTNmtVS0tsemRId2JPY0l4ZURWKzRmU0NLVTRZ?=
 =?utf-8?B?a3hqUEZQNlJuQXQzQytxZCt2NExBK2EwdlpaWXlUNy81SDhlMVV3NUdwMUZZ?=
 =?utf-8?B?cUY0ZG43M1FLTjg1WjhuRk9NU2pJTi9VRDRDKzNXeDRZOXZJdTF0Q1JTWnR0?=
 =?utf-8?B?NXNROVRTMXNndW5mVTd1bnZZYmhFUE9qMXpBaHBJTk42Vk5iZXhMMnVJTWtT?=
 =?utf-8?B?YmxZM0lQblZrUGZ6ay8xTXY2Y050a1NmK0tZaVVyMUVmRzQ3ZjI2U3A2aUlZ?=
 =?utf-8?B?Ty9MOERNdStBcS9IaEtSc2krL0ZzSzg0ZlExd1hyZWlBa1dpMHNmQmpmMm85?=
 =?utf-8?B?L1NnbGNKd1pxbnQrc1VsSmcxVThjVVpIYWNaMGlzWlVrWktkUmRaaWZmU0hh?=
 =?utf-8?B?bHNGbHNVdVhjVXlyMm5YTmR0NWptUU1xUC9DUEN5di85eWxXUmdVV0ZteExS?=
 =?utf-8?B?dDZkRTIrb2d5bUNleEJSd240cTRoSUltaUVSdWRINHcvTUFNUEg3QlptRU83?=
 =?utf-8?B?UVFMVkNQQXliZlBtTWdRT0ZhNUZQdHhTV3ZyUldBcEdWWEwzQ3N3TmRFWDhu?=
 =?utf-8?B?bnIyeTBLMy9uV0VXZXlUNlU2bUVFTEI1SjRaSkpoWXp4V3ViWEJISEZLYmc4?=
 =?utf-8?B?Q2tDbFhML0dlcmxMOW5qb2FscmZJLzh4QVVkZHFZV1MrR1Y3TjJQKzNCOHpt?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B349E2A7083FE419FB0DBCA321FB7A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	63n5fdbDC7iu2S2rLIrJsE218Qh++a5cpeTeHf54okIk2RexY8nRjg6nYUBzYxcpNwTNRQ6IdeMr6iHzwJ3+31Ppom4FEziLYjvqnkHfZD6UN79W8d3p6R1/fswGcPLyYtpoU17HidaBIMw9n/cXZ3YL1E8Eoy8hRcNFv6iAFmaeQZzEZmp6/idBskVL2+5nY3jbw+L5B4IFVHQkoeCwe8+FEBgrLGN7q9wwfw2afdmVVRZBYnjiqBVXhRSKcUgk7f+xrlxI+FzaYPnQHqnsKDPBjgHKui3Y/69z0+0hVdgRGD8bDM7zz0+Hke+NVaGOuWgd56Duvto5sSbk4eQDHMFP60qm5F8O8kqFYtIxFenbxeLwvt2ENDogyry+ZBHoDRg5+J1kc3kjMjoBXpzBnXUWF0GI+rMf0u2+gEnnmqLcmyPGK22J1Iw9gAFdHszHVZ1/yXGja2icNbwDprMob/Dhx7oTlGURl16r9sswsTWk6CDh3TR8OKgq/66CDNgzbz8tcH4+Kt+bFoGpSPSzZCOtP0CjIkp1TNPtdDvJ5diQztQbGRJep8wp2pHVxcSsdGCnPwuLGE+GFwKntcN8LgeV+1E413vANuFAGObd5A0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9416d55-477a-4ee1-3d7d-08dc3d3f513c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 18:08:53.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7P0ibjGjkG3vfQ3qq/KU/SyfbGL0FArH7r2qp4l7FUkwilssZd/MuSDpYasqgvyviJV+SIB85zdj3S0tSJ50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_15,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050145
X-Proofpoint-ORIG-GUID: oyvB2VtysGObRPrFGiZMb7aeKC_u2rwB
X-Proofpoint-GUID: oyvB2VtysGObRPrFGiZMb7aeKC_u2rwB

DQoNCj4gT24gTWFyIDQsIDIwMjQsIGF0IDc6MTHigK9QTSwgRG9taW5pcXVlIE1hcnRpbmV0IDxh
c21hZGV1c0Bjb2Rld3JlY2sub3JnPiB3cm90ZToNCj4gDQo+IEhpIENodWNrLA0KPiANCj4gQ2h1
Y2sgTGV2ZXIgSUlJIHdyb3RlIG9uIE1vbiwgTWFyIDA0LCAyMDI0IGF0IDA1OjI5OjI0UE0gKzAw
MDA6DQo+PiBXaGlsZSB0ZXN0aW5nIGxpbnV4LW5leHQgKDIwMjQwMzA0KSB1bmRlciBrZGV2b3Bz
LCBJIHNlZQ0KPj4gdGhpcyBLQVNBTiBzcGxhdCwgc2VlbXMgMTAwJSByZXByb2R1Y2libGU6DQo+
IA0KPiBUaGFua3MgZm9yIHRoZSByZXBvcnQgLS0gdGhlcmUncyBhbHJlYWR5IGEgZml4IGZvciBp
dCBidXQgd2UndmUgYmVlbg0KPiBzaXR0aW5nIG9uIGl0IGZvciBhIHdoaWxlLCBzb3JyeToNCj4g
aHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDI0MDIwMjEyMTUzMS4yNTUwMDE4LTEtbGl6aGku
eHVAd2luZHJpdmVyLmNvbQ0KPiANCj4gSSd2ZSBwaW5nZWQgRXJpYyB5ZXN0ZXJkYXkgdG8gdGFr
ZSB0aGUgcGF0Y2ggYXMgdGhlIHByb2JsZW0gaXMgaW4gaGlzDQo+IC1uZXh0IHRyZWU7IGhvcGVm
dWxseSBoZSdsbCBiZSBhYmxlIHRvIGhhdmUgYSBsb29rIHNvb24gYnV0IHVudGlsIHRoZW4NCj4g
cGxlYXNlIGFwcGx5IHRoZSBwYXRjaCBkaXJlY3RseS4NCg0KVGhhbmsgeW91LCBEb21pbmlxdWUh
DQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

