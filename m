Return-Path: <linux-fsdevel+bounces-31746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0465C99AB1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4337283FBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68F1C9DF9;
	Fri, 11 Oct 2024 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WaVYT6Nu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f0+/XUvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5F183CA5;
	Fri, 11 Oct 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672031; cv=fail; b=n+lEGR20YoxbUZOuNIf2zmAdg/3l/iQK+xIe8cP1c+9rda29gMWUH5mUxiMMB4E8fFUXVBgXdv6ryUC7mCMcwBNg8BuKsvooRFUL8zbnbjkTZg5AU4s4/A9kkgW7NPtKhaQ8DxnlLTjKAzLJU+knVI1NQuSoAiMzKk/LGseXLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672031; c=relaxed/simple;
	bh=o4vDKn50D0HkE7lo9ZkvL/SDpAs5fgv7HUew4wLXI58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gsv/zVSYTEq/D5zuFfngHf41BlAqAGMSRd0MpdlgZmeonUN4NGVwzGm4ygwfz5WghF6YiildG3AP+KJh0oKCiXpKp0D+VEWkJZGINOb2t+MwY/UZmK7H6qD37nWbR8ZRebdA3jPxsoJA75u0AjcIkM3AY5MUD2h+RZo92+mmY/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WaVYT6Nu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f0+/XUvE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpU6x000477;
	Fri, 11 Oct 2024 18:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=o4vDKn50D0HkE7lo9ZkvL/SDpAs5fgv7HUew4wLXI58=; b=
	WaVYT6NuwlgdlgBXYU2UuZnUdlNrdMEOjCfgptr11GnGoQtOEg30lC49qQC+yxVT
	E7Yf/iFuGH2DDlGiOEaUSzwiO/V0KH8uvqHsdnV/45w/RUKCH8MFjI3YmNEliKqg
	dM14WhSbcchEOL4DCYOyQeQgZlM66uZCMSlLdB7OQWQBKMMxFCJ7Fds2N85KbBh3
	nR3/i0yC4wTHxrDWCv2ilS+aMmcU1ad9Zudk1vFIpejiW5R4S3uuIByZ+WzeC854
	CcvL8yybJb6dL7NuQMQugWrTPMPjGqCVOK3QhO4f9QuVEZHxRw6DyjCfw77iVJqa
	XfGFRUknuK036X6wqAF6Hg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034x02r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 18:40:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BGql0f020626;
	Fri, 11 Oct 2024 18:40:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbq4cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 18:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1WcYcqJw95NXeXNp+SxdMgZfGn4EHl8oA3AyHDJQKKaIYg9muND+vHS+12VoUD7ZFY8gPrMUfAVKmS0+eBJRj+4nyg6CJwJW6DJCyBxBM6sOpOg04iSdkja/DwCGfSFPwUzFw+LnNQ8EnubQDB0flxMDwGq/+AHmjPC46vO+oDYjEy4ANWveJKqtVn+kLW7GMHk5r6QtrKVbfJORJ695QTu3rvGWxsGtN2mIR9bmKEiCRAuEORIcUzBAS7JFjIZEPPVBihYqkuwS73HRjcPz5mOOmXMZ9ogzl+Dzv4IzN0I3sAkw6H5SCjuCtwyYj7BD9SEpRmrY3r2Vli041zcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4vDKn50D0HkE7lo9ZkvL/SDpAs5fgv7HUew4wLXI58=;
 b=inKl0hH9CifFfX+OHt1kWmM4tyeJC4SxoNdy2v0CKabhg3uTvJhX29b9Zu5i1/40wROqewg7reWOFKWmL5YvxRS9q1sLbCwCEq4C4Aqgs7DrKlbZNajZTVJCvD3olTnBhjdUgnpw/A69bCGqssivJYpdp7M8ZP7OB+SrGHukZX952jM5bVqfJruZWoXnbU1b2TFI+oRlNj0BYjhp/E5mD12FiWw472JcO106DQWFEOCY3QnV7A9MgHR+9pox62hXzoyS4UImdlu9dUSZyRHbvOwV/D7RoT6Vf0Oy2fwtQcv87OZpLfEC6UEFXEz89BccVRZrP8g8ptKB4XwEg0Cl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4vDKn50D0HkE7lo9ZkvL/SDpAs5fgv7HUew4wLXI58=;
 b=f0+/XUvEIN14tuHUnDu+ElzlxWAzcje/33hVIYZLA15xuXxMOmZW2pANcqRw3YS9csITyn1pZMDEXHojkxsAgLiKgmGeMGD6ht7PfW7gZpbVXD/U4bFEOvWJUl3MaHRbYinVYpaWXgE21bbUJjmwi3+lfEpiWcYyGOI2i+1ahRI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7603.namprd10.prod.outlook.com (2603:10b6:208:485::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 18:40:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 18:40:08 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel
	<linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] API for exporting connectable file handles to
 userspace
Thread-Topic: [PATCH v4 0/3] API for exporting connectable file handles to
 userspace
Thread-Index: AQHbG7wKQIu2WXCvZ0Gg1IHTT7WC0rKBmw8AgABCj4CAAATagA==
Date: Fri, 11 Oct 2024 18:40:08 +0000
Message-ID: <743E221E-6137-4525-9F89-20E06CD404E4@oracle.com>
References: <20241011090023.655623-1-amir73il@gmail.com>
 <A1265158-06E7-40AA-8D61-985557CD9841@oracle.com>
 <CAOQ4uxgX+PqUeLuqD47S5PxeYqJ3OMs0bfmnUE+D7dcnpr-UNw@mail.gmail.com>
In-Reply-To:
 <CAOQ4uxgX+PqUeLuqD47S5PxeYqJ3OMs0bfmnUE+D7dcnpr-UNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA0PR10MB7603:EE_
x-ms-office365-filtering-correlation-id: a62f3bbb-459f-45fd-f3c9-08dcea2421ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QXB2a05wOVFTekFkM1FheWx2REpXbDVxQUc5VlpUSjFuSDhHS0g2dHBxaitv?=
 =?utf-8?B?SHM2VE1vRUZ0OUxURlFDcVlWSFFXdktySmxJVFJsbDk0UFZKK0hIbWVtSmFS?=
 =?utf-8?B?TGU1czIwOFhKVmcybGZqbWV1bnVaWDlSdGhWYmdHVzFWTTVRaEw4dWk3bi80?=
 =?utf-8?B?WkZnMzJOcGJweTZENlVPMG1MSVJPcFFDWHNpckdiSzJDeDZOUDhEaDJJVkNk?=
 =?utf-8?B?OHdoSCtqbFJpbmRmVmtsNm83Q1hIekZIc1pFTUlNOWE4N1hmZVcxR3hqL0Fr?=
 =?utf-8?B?bk8xa3FQb0JZbVVHc3k0QWxoME12TjQxVjVET29ud29IVjhsekE0TEtoM2pk?=
 =?utf-8?B?VSs1TmNKVGNnYmZMUkJkQkMrdGsxOFRoNXU3R1Q3YXN5YzRFRzBrbUx5Zmtp?=
 =?utf-8?B?VTJWc3ovc1g5QVZzOG5KVmRVdzNhcXM4ayt3M2kzcDZqNUJ0VzBzMkozZzhM?=
 =?utf-8?B?QkVJRHdHMHFRUlJKTi9EUER4WWxZTlBwZ3g0R2U1RHNiY000M1RtQWhxajFP?=
 =?utf-8?B?aHltNENnL0ZVV1gvUEFoeXllOXdRbTNXWmVVcHJhTlJyZ2lzK3A1MUYyZ3VL?=
 =?utf-8?B?THJ2N1M5OWhEcmZOOUM0Q3Z3R0tSb3djU1NCVTl2OUpMOTdJWU9lV0lwR3Q0?=
 =?utf-8?B?MWVybk5JZUhNVkFSOWJXcWFBUDMvakxjZzZmOUJweHhIb29RVzRkZWN3VlhN?=
 =?utf-8?B?cUVMckcxVG5ybFpqQmlwd0xxQ2NFQmZxaGo0Y3lHRncrWmtZZFpYSFZqWGxI?=
 =?utf-8?B?czRXTHFjV1laMlMxRU5wOFBLUnBERTNZd2lRcXVlc2tsTXNYb2EvNk5kQW82?=
 =?utf-8?B?dWE0aStwNWUwWGNnYXRNZVhsT1E2dXBCU1FxcWFXYnU5MlR0NlFzVVZMVENB?=
 =?utf-8?B?SXdJWUxMaWpTWU1MVWk3V3JYdi9JYnpFdHp3QVpGVnZYZGNNSnA4K2YvSko4?=
 =?utf-8?B?bmVweVlsVzVGUmdJeDMrQkFPV3NhNTZSMktQNDYzQWNhVit2YXlkNjM0N1Bl?=
 =?utf-8?B?MzI4QW9WT05HcWFXdTF3cGk2TXh0a29kMzlaMS9CcU03cEF2VUErZEV1WWQ5?=
 =?utf-8?B?bVB3L0ZnZGk5SWZjamw3dXV3NUY1cUZGQm14UE8xYkpvUEFQSmtmcUJVZnNG?=
 =?utf-8?B?Z2xPZkdRNE1MQXp3eFY3dmcvYUZRREZsT0t6NmczSlpiQTJ4QWFNbGxjZ2ps?=
 =?utf-8?B?em5JTW02ck1UbHI3S1Uxb0VMZEc3R3ZXb0dIOGVkUytraEtKelFyZS81cDQ5?=
 =?utf-8?B?ZnJHRDE0SWJIUjIyT21yZXMyWVY0Z3ByVklCR2hYTHBhSzl1M1Ryakcrb25T?=
 =?utf-8?B?UUZoVDc2R0JYbkhQenRoRnBZQTB3bXMzbitYbFd3V0NGWVhoYllhK1NmYWVF?=
 =?utf-8?B?OFM0QkFVaFBxQnV4eVg5UldaRzkyM2F4T3hBU0xxZWx6R2J1ZkNqSGJKR3dx?=
 =?utf-8?B?d3hnU1BYZitWSTFGQzAwVFVZMkRiakVtejA4cTA5TDlqT1lFNERWOHhYZVFo?=
 =?utf-8?B?U0JleG9xcHpSVWh4TUhpc1RJTzRaRHNrZElJSXdneDNSdmJKd0RjYXFSd0Jh?=
 =?utf-8?B?MnBHYml3RC82dEZUanpRY2FraE9qcjJNbUpwMTRGMjR6R1g2VjVsSUZscVpN?=
 =?utf-8?B?YzZ1cWZkbWIyVmVzWitiUEFNcWthSDNkTUNsMGNnbUIyU1JkNHFscFdyTUpq?=
 =?utf-8?B?ajYzZHNJb2hoNUZUb29tUnZhQTRmV1h1NFJ5N2k4TWRjamhpUEtURHJyaWFS?=
 =?utf-8?B?NjhuTklDbEFaaGFEdlFkNnZJcEQxcUhlSjlFQldhZVdYb2VzMkk0Z2dCUWU0?=
 =?utf-8?B?eGZMc1ZhRHY2UnFjcXkxdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3Q5bHBFdFBzaE55UFRtazhnVmYvRjVablB1czM4QkJUU0RqRVQ0N3JrOUJy?=
 =?utf-8?B?Rm5WdW04V0NPdUdJSGU0b0x2NlZjWlIrRnhFajRwU2JJNHcxRVJBUEs0WWtW?=
 =?utf-8?B?NldvV3ZRQS9XMW9QRnNaNGd4V2RPYStvZmFoSWVrMUx1QjZ4K0YzbHhXOCtt?=
 =?utf-8?B?ZU9sM0M0T05yVm5pdC9QTDJ2SUZxZ1ViVVpJVUZkWXBNZFJoMm1mSlJReEZB?=
 =?utf-8?B?ZkpjNGpyajZRS3dEYkx4dURLY0FzaWRLU1REVmNKOVBmUGo5TXdBN2JqbVpW?=
 =?utf-8?B?eCtaODBSVVZTRVlIUkk5WFFaVjEzK3N2bGwyNThlaTlubzhiVExnaHlib0hk?=
 =?utf-8?B?R2oyQVpKUEtxNjBaemNtZ09tVjU5d2ZadVJFeXd1MkFlRTJ1RytRSkpBbUxP?=
 =?utf-8?B?SCtBZWVVcUZ6OEZmZDF3WVRCa0VzNXloc2Njc0oxbVBGTkhJV1lqMm5rYWYr?=
 =?utf-8?B?OGJxM3hDMldMdjlzZkFIOVRuc2lsSmlyejRkS1Z4N3pzTUp5enUzY0JjTmxK?=
 =?utf-8?B?aGpHdXZKSExOQWF4ZW13OVh2M09hZjA2NnRMOVE0RkZyUmVGczhmbmhyUjlu?=
 =?utf-8?B?U1VZdU5zMnM0SXpmUmpmZ0lmdmlLUXhRU1RPMkcwTE0yck4xbXlYWmFiRHIx?=
 =?utf-8?B?TTlFNTg5MkxBbkJmeERDS0dUTVRJN0lYSmwxR2tQU3VYazZOTTR6TUdCWWxo?=
 =?utf-8?B?aEI1YzJpMm9wV25ZMitneEtKNlpSZ010VGVHQWx2M3NNWGE2YWFQWjFzUFhK?=
 =?utf-8?B?RzhaWFlkYnljNlBQVHM2cHpXQU0xOExsbWV6dUxmdllZQ0dOanBvQmFpUDhm?=
 =?utf-8?B?R0RUbkprYmRXMmFPOXhHL1dWQkRhRGc0UmRhL004bkRyVjJkVnA2MlJtS0JM?=
 =?utf-8?B?Q24vbldGTjN5eEpmZWo2SGRucmtRNG1obGw3alVWV0ZlZHVxRFg1R3FlbVBp?=
 =?utf-8?B?NXR6WExSZDJWOEErcEdQV0l0ZU8yRkh6ZjFCVDJzVW9SR3pRdWlyejNNaEEr?=
 =?utf-8?B?YTZNenNUeDVuL3prMmVyWXlLWHF0K1IvRkNicHh4RnB2NVZUZzE4NlUyZFl1?=
 =?utf-8?B?T0o3bUZiK3hFVmRMdktqZS9FK002QjhpMlBSN2VhQUhFbitZSFFpbUEyTGRU?=
 =?utf-8?B?eXNMUkZLU0tONnJ6bmZON1pDT3lieHpTYmdwbk14OXNhcGt4WGpMMlJRM0JK?=
 =?utf-8?B?aC9kTFgxVjU3bEdDbjdCamJyTk1xcVk0dlhCVW42Mm1yaDNTclpXQmVnTEhU?=
 =?utf-8?B?NlZWd2VoOGtFaVcvOWNOM1lWS3pFM0Y2MmlmWU1HYSttVDQrNlFJQ2ViOFpo?=
 =?utf-8?B?a0FQZ1N3MDI4Y0NRREZlcjZwUE1aRk0xcGpIL0JRQ0tLN0JBenpycnVNMStE?=
 =?utf-8?B?QjVqcWYzZ2RzcVpRcjd3cm9IL0JJVEQ0cGdYVitMZEtpOVYyengvRUVBUGc2?=
 =?utf-8?B?UDVjeDcxQVhVMVNvZ3JBak0xRDdoRVVUNDlvaGxsYnpudHp3cEw0OUV0TG8x?=
 =?utf-8?B?SHBWVzgwS3R3RzQ2aTBWd2dWcVlOang1VTlyZ0o1M0RJekI3VzAyYUdJK2hQ?=
 =?utf-8?B?aHVWZ0x4TlZIbHh5L3c4QllJQVRUMWdKNUdLZE9tOVhUU216ZHJqWHhLNWdC?=
 =?utf-8?B?bGk5SnhsQzNoeVprSWN0MUlLanhCMDBVK0RsdHNUNGJvQi93bmtrNDhxQjhw?=
 =?utf-8?B?anJRd2RNTU0rTmJDazIwM2xlcjd3N2l6SFY4RVZ0OUF2cU1mbGJINmwyZ0N0?=
 =?utf-8?B?VUpHOElNRmc5QkdHblVBcmo2UWR2cXBpMExaNjhseGZEVHcxZ2Rqb096K0k0?=
 =?utf-8?B?eEVRb1FXTUFETDZBbGQyMWduK2FQK1pLSmE0eVl1UnZDUUo4bFVhai9qYk9y?=
 =?utf-8?B?aGgxSDVGNFArejkvTG9hTWltTEkvUGFJR25EREpMdXozWStlQzB6S0JvK24w?=
 =?utf-8?B?MGxBenVZOEZCaHFsamF4RzFrQmQyRnIvT2NmVkZNNlpjTURTdldlK0pPQ2J0?=
 =?utf-8?B?blgzMXI1dGkzNG4wbEV1c1Y5eS9lL1cxYzhNR0VKb3ZRV3JtaE5BMEVCSDla?=
 =?utf-8?B?M0QyL0xRSXo2cmE2a1RvaGNvZUp5NFdZOGFVYzFJU1RaSWJLaTVPTFFCVUUv?=
 =?utf-8?B?SmlhRXdSdENoTVgvdGhZdEFJUHdqZjVMN2swMERySUVkRmlDVlNEYkdyLzk4?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BA9AA188D259142AEC8CD68B7E6D117@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7IV28jhCyDUJLB0S88er/zH5WzTn7NUJ6DUywx5MQbMNSYZIw5V2u0cCtyg8FNvSj+evLP4lJglA5ntZCEGkYKJlxZOokTsn1P94rZO0vJamWx1FqP71CerarCsqoq2k8wGYr8btX56CMLqdsBPMPFzf7eZOt5zdIcx7GMpfUCisW0YjYpsVtmpRM2/8hdpyvJKjKC1iaPQO2+hkI0SnskYZ+ilonWGLgllpZ61CM1GkW2GlxjIux/jSrF3dB7P1BdqkLL0j48CkZpSsQkY9ETzAd+oY0HExACJmPFJrZuYxK+a3kdVcD+7llQWZ07NRvXLD5nHKr2HEC8Cu4/u0S2g7/8P7DYW9ytoSVEst2faCaMVtY5hrvc7UqSW5l7/7wNnjACB54iR3j/FPfWVwCY9NV/8aYNLc+dPbaRb2tgC9PZ+c2liMPWuuVieQ3I09HCGBrg/wv5qEJslMCxr2M5f1m7wEXrMjM/8fkg2c/KBB5MC5KRni5Nuf7ujg6dyVCA/m9oP5EGXXxW+HxdwhSgRGTQktKA+FVlgzzuuKxYOJQxCTAbZYCi82Iwy1OvQ0w3BlYQu2UWl/qQ1NFSIUps1whrskK/EttmP7aelW5Zo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62f3bbb-459f-45fd-f3c9-08dcea2421ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 18:40:08.4129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OJuUGcUjpcCWTvLpTnAv8rr3ag44fq6ZinDxwcSr4N8+fx43lmF2aCgs9huhUoxo5YyW3wZx1rhN5/vY9VLBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_16,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110130
X-Proofpoint-GUID: UWErPCxdysyIjNVEog5HhDLQervbpQpI
X-Proofpoint-ORIG-GUID: UWErPCxdysyIjNVEog5HhDLQervbpQpI

DQoNCj4gT24gT2N0IDExLCAyMDI0LCBhdCAyOjIy4oCvUE0sIEFtaXIgR29sZHN0ZWluIDxhbWly
NzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBPY3QgMTEsIDIwMjQgYXQgNDoy
NOKAr1BNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+
PiANCj4+IA0KPj4gDQo+Pj4gT24gT2N0IDExLCAyMDI0LCBhdCA1OjAw4oCvQU0sIEFtaXIgR29s
ZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IENocmlzdGlhbiwN
Cj4+PiANCj4+PiBUaGVzZSBwYXRjaGVzIGJyaW5nIHRoZSBORlMgY29ubmVjdGFibGUgZmlsZSBo
YW5kbGVzIGZlYXR1cmUgdG8NCj4+PiB1c2Vyc3BhY2Ugc2VydmVycy4NCj4+PiANCj4+PiBUaGV5
IHJlbHkgb24geW91ciBhbmQgQWxla3NhJ3MgY2hhbmdlcyByZWNlbnRseSBtZXJnZWQgdG8gdjYu
MTIuDQo+Pj4gDQo+Pj4gVGhpcyB2NCBpbmNvcnBvcmF0ZXMgdGhlIHJldmlldyBjb21tZW50cyBv
biBKZWZmIGFuZCBKYW4gKHRoYW5rcyEpDQo+Pj4gYW5kIHRoZXJlIGRvZXMgbm90IHNlZW0gdG8g
YmUgYW55IG9iamVjdGlvbiBmb3IgdGhpcyBuZXcgQVBJLCBzbw0KPj4+IEkgdGhpbmsgaXQgaXMg
cmVhZHkgZm9yIHN0YWdpbmcuDQo+Pj4gDQo+Pj4gVGhlIEFQSSBJIGNob3NlIGZvciBlbmNvZGlu
ZyBjb25lbmN0YWJsZSBmaWxlIGhhbmRsZXMgaXMgcHJldHR5DQo+Pj4gY29udmVudGlvbmFsIChB
VF9IQU5ETEVfQ09OTkVDVEFCTEUpLg0KPj4+IA0KPj4+IG9wZW5fYnlfaGFuZGxlX2F0KDIpIGRv
ZXMgbm90IGhhdmUgQVRfIGZsYWdzIGFyZ3VtZW50LCBidXQgYWxzbywgSSBmaW5kDQo+Pj4gaXQg
bW9yZSB1c2VmdWwgQVBJIHRoYXQgZW5jb2RpbmcgYSBjb25uZWN0YWJsZSBmaWxlIGhhbmRsZSBj
YW4gbWFuZGF0ZQ0KPj4+IHRoZSByZXNvbHZpbmcgb2YgYSBjb25uZWN0ZWQgZmQsIHdpdGhvdXQg
aGF2aW5nIHRvIG9wdC1pbiBmb3IgYQ0KPj4+IGNvbm5lY3RlZCBmZCBpbmRlcGVuZGVudGx5Lg0K
Pj4+IA0KPj4+IEkgY2hvc2UgdG8gaW1wbGVtbmVudCB0aGlzIGJ5IHVzaW5nIHVwcGVyIGJpdHMg
aW4gdGhlIGhhbmRsZSB0eXBlIGZpZWxkDQo+Pj4gSXQgbWF5IGJlIHRoYXQgb3V0LW9mLXRyZWUg
ZmlsZXN5c3RlbXMgcmV0dXJuIGEgaGFuZGxlIHR5cGUgd2l0aCB1cHBlcg0KPj4+IGJpdHMgc2V0
LCBidXQgQUZBSUssIG5vIGluLXRyZWUgZmlsZXN5c3RlbSBkb2VzIHRoYXQuDQo+Pj4gSSBhZGRl
ZCBzb21lIHdhcm5pbmdzIGp1c3QgaW4gY2FzZSB3ZSBlbmNvdXRlciB0aGF0Lg0KPj4+IA0KPj4+
IEkgaGF2ZSB3cml0dGVuIGFuIGZzdGVzdCBbNF0gYW5kIGEgbWFuIHBhZ2UgZHJhZnQgWzVdIGZv
ciB0aGUgZmVhdHVyZS4NCj4+PiANCj4+PiBUaGFua3MsDQo+Pj4gQW1pci4NCj4+PiANCj4+PiBD
aGFuZ2VzIHNpbmNlIHYzIFszXToNCj4+PiAtIFJlbGF4IFdBUk5fT04gaW4gZGVjb2RlIGFuZCBy
ZXBsYWNlIHdpdGggcHJfd2FybiBpbiBlbmNvZGUgKEplZmYpDQo+Pj4gLSBMb29zZSB0aGUgbWFj
cm8gRklMRUlEX1VTRVJfVFlQRV9JU19WQUxJRCgpIChKYW4pDQo+Pj4gLSBBZGQgZXhwbGljaXQg
Y2hlY2sgZm9yIG5lZ2F0aXZlIHR5cGUgdmFsdWVzIChKYW4pDQo+Pj4gLSBBZGRlZCBmc3Rlc3Qg
YW5kIG1hbi1wYWdlIGRyYWZ0DQo+Pj4gDQo+Pj4gQ2hhbmdlcyBzaW5jZSB2MiBbMl06DQo+Pj4g
LSBVc2UgYml0IGFyaXRobWV0aWNzIGluc3RlYWQgb2YgYml0ZmlsZWRzIChKZWZmKQ0KPj4+IC0g
QWRkIGFzc2VydGlvbnMgYWJvdXQgdXNlIG9mIGhpZ2ggdHlwZSBiaXRzDQo+Pj4gDQo+Pj4gQ2hh
bmdlcyBzaW5jZSB2MSBbMV06DQo+Pj4gLSBBc3NlcnQgb24gZW5jb2RlIGZvciBkaXNjb25uZWN0
ZWQgcGF0aCAoSmVmZikNCj4+PiAtIERvbid0IGFsbG93IEFUX0hBTkRMRV9DT05ORUNUQUJMRSB3
aXRoIEFUX0VNUFRZX1BBVEgNCj4+PiAtIERyb3AgdGhlIE9fUEFUSCBtb3VudF9mZCBBUEkgaGFj
ayAoSmVmZikNCj4+PiAtIEVuY29kZSBhbiBleHBsaWNpdCAiY29ubmVjdGFibGUiIGZsYWcgaW4g
aGFuZGxlIHR5cGUNCj4+PiANCj4+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
ZnNkZXZlbC8yMDI0MDkxOTE0MDYxMS4xNzcxNjUxLTEtYW1pcjczaWxAZ21haWwuY29tLw0KPj4+
IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjQwOTIzMDgyODI5
LjE5MTAyMTAtMS1hbWlyNzNpbEBnbWFpbC5jb20vDQo+Pj4gWzNdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWZzZGV2ZWwvMjAyNDEwMDgxNTIxMTguNDUzNzI0LTEtYW1pcjczaWxAZ21h
aWwuY29tLw0KPj4+IFs0XSBodHRwczovL2dpdGh1Yi5jb20vYW1pcjczaWwveGZzdGVzdHMvY29t
bWl0cy9jb25uZWN0YWJsZS1maC8NCj4+PiBbNV0gaHR0cHM6Ly9naXRodWIuY29tL2FtaXI3M2ls
L21hbi1wYWdlcy9jb21taXRzL2Nvbm5lY3RhYmxlLWZoLw0KPj4+IA0KPj4+IEFtaXIgR29sZHN0
ZWluICgzKToNCj4+PiBmczogcHJlcGFyZSBmb3IgImV4cGxpY2l0IGNvbm5lY3RhYmxlIiBmaWxl
IGhhbmRsZXMNCj4+PiBmczogbmFtZV90b19oYW5kbGVfYXQoKSBzdXBwb3J0IGZvciAiZXhwbGlj
aXQgY29ubmVjdGFibGUiIGZpbGUNCj4+PiAgIGhhbmRsZXMNCj4+PiBmczogb3Blbl9ieV9oYW5k
bGVfYXQoKSBzdXBwb3J0IGZvciBkZWNvZGluZyAiZXhwbGljaXQgY29ubmVjdGFibGUiDQo+Pj4g
ICBmaWxlIGhhbmRsZXMNCj4+PiANCj4+PiBmcy9leHBvcnRmcy9leHBmcy5jICAgICAgICB8IDE3
ICsrKysrKysrLQ0KPj4+IGZzL2ZoYW5kbGUuYyAgICAgICAgICAgICAgIHwgNzUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4+PiBpbmNsdWRlL2xpbnV4L2V4cG9ydGZz
LmggICB8IDEzICsrKysrKysNCj4+PiBpbmNsdWRlL3VhcGkvbGludXgvZmNudGwuaCB8ICAxICsN
Cj4+PiA0IGZpbGVzIGNoYW5nZWQsIDk4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+
Pj4gDQo+Pj4gLS0NCj4+PiAyLjM0LjENCj4+PiANCj4+IA0KPj4gQWNrZWQtYnk6IENodWNrIExl
dmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tIDxtYWlsdG86Y2h1Y2subGV2ZXJAb3JhY2xlLmNv
bT4+DQo+PiANCj4+IEFzc3VtaW5nIHRoaXMgaXMgZ29pbmcgZGlyZWN0bHkgdG8gQ2hyaXN0aWFu
J3MgdHJlZS4NCj4+IA0KPj4gSSdtIGEgbGl0dGxlIGNvbmNlcm5lZCBhYm91dCBob3cgdGhpcyBu
ZXcgZmFjaWxpdHkgbWlnaHQgYmUNCj4+IGFidXNlZCB0byBnZXQgYWNjZXNzIHRvIHBhcnRzIG9m
IHRoZSBmaWxlIHN5c3RlbSB0aGF0IGEgdXNlcg0KPj4gaXMgbm90IGF1dGhvcml6ZWQgdG8gYWNj
ZXNzLg0KPiANCj4gVGhhdCdzIGV4YWN0bHkgdGhlIHNvcnQgb2YgdGhpbmcgSSB3b3VsZCBsaWtl
IHRvIGJlIHJldmlld2VkLA0KPiBidXQgd2hhdCBtYWtlcyB5b3UgZmVlbCBjb25jZXJuZWQ/DQo+
IA0KPiBBcmUgeW91IGNvbmNlcm5lZCBhYm91dCBoYW5kY3JhZnRlZCBmaWxlIGhhbmRsZXM/DQoN
ClllczsgYSB1c2VyIGNvdWxkIGNvbnN0cnVjdCBhIGZpbGUgaGFuZGxlIHRoYXQgY291bGQgYnlw
YXNzDQp0aGUgdXN1YWwgYXV0aG9yaXphdGlvbiBjaGVja3Mgd2hlbiBpdCBnZXRzIGNvbm5lY3Rl
ZC4gSXQncw0KYSBsaXR0bGUgaGFyZS1icmFpbmVkIGFuZCBoYW5kLXdhdnkgYmVjYXVzZSB0aGlz
IGlzIGEgbmV3DQphcmVhIGZvciBtZS4NCg0KDQo+IENvcnJlY3QgbWUgaWYgSSBhbSB3cm9uZywg
YnV0IEkgdGhpbmsgdGhhdCBhbnkgcGFydHMgb2YgdGhlIGZpbGVzeXN0ZW0NCj4gdGhhdCBjb3Vs
ZCBiZSBhY2Nlc3NlZCAoYnkgdXNlciB3aXRoIENBUF9EQUNfUkVBRF9TRUFSQ0gpDQo+IHVzaW5n
IGEgaGFuZGNyYWZ0ZWQgY29ubmVjdGFibGUgZmlsZSBoYW5kbGUsIGNvdWxkIGhhdmUgYWxzbyBi
ZWVuDQo+IGFjY2Vzc2VkIGJ5IHRoZSBwYXJlbnQgZmlkIHBhcnQgYmVmb3JlLCBzbyBJIGRvIG5v
dCBzZWUgaG93IGNvbm5lY3RhYmxlDQo+IGZpbGUgaGFuZGxlcyBjcmVhdGUgbmV3IHdheXMgdG8g
Z2V0IGFjY2Vzcz8NCj4gDQo+PiBCdXQgZm9sbG93LXVwIGNvbW1lbnRzIGZyb20gQW1pcg0KPj4g
c3VnZ2VzdCB0aGF0ICh3aXRoIHRoZSBjdXJyZW50IGNvZGUpIGl0IGlzIGRpZmZpY3VsdCBvcg0K
Pj4gaW1wb3NzaWJsZSB0byBkby4NCj4+IA0KPj4gQXJlIHRoZXJlIHNlbGYtdGVzdHMgb3IgdW5p
dC10ZXN0cyBmb3IgZXhwb3J0ZnM/DQo+IA0KPiBUaGVyZSBhcmUgZnN0ZXN0cywgcGFydGljdWxh
cmx5LCB0aGUgImV4cG9ydGZzIiB0ZXN0IGdyb3VwDQo+IGFuZCBJIGFkZGVkIHRoaXMgb25lIGZv
ciBjb25uZWN0YWJsZSBmaWxlIGhhbmRsZXM6DQo+IA0KPiBbNF0gaHR0cHM6Ly9naXRodWIuY29t
L2FtaXI3M2lsL3hmc3Rlc3RzL2NvbW1pdHMvY29ubmVjdGFibGUtZmgvDQo+IA0KPiBEaWQgeW91
IG1lYW4gYW5vdGhlciBmb3JtIG9mIHVuaXQgdGVzdHM/DQoNCk5vLCBhY3R1YWxseTsgZnN0ZXN0
cyB3Zm0uIFRoYXQncyBzb21ldGhpbmcgSSBjb3VsZCBzZXQNCnVwIHZpYSBrZGV2b3BzIGFuZCBy
dW4gb24gYSByZWd1bGFyIGJhc2lzLg0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

