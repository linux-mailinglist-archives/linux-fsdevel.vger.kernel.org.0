Return-Path: <linux-fsdevel+bounces-650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933DC7CDD8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C5F281BC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685FA358BE;
	Wed, 18 Oct 2023 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Z2kYEgzy";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="LA34Q5J3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111F18636;
	Wed, 18 Oct 2023 13:40:14 +0000 (UTC)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E336ABA;
	Wed, 18 Oct 2023 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5941; q=dns/txt; s=iport;
  t=1697636412; x=1698846012;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+zDupWqIRJNfuG+oj4XxwiBaZkueALv8xAxkFTk80hU=;
  b=Z2kYEgzytNbe11G9jcSAJMnXK3RhvWiJjo4Uk7IW6IZfWZcUnR3vjWyj
   9BKLizMVL4kjAzKGlMBT6XtWtiV8kem1iJCpGHr175WIw/HhijVmnZjh/
   K+EOQsW1TK7OPC+q2z680H11X4FzqNDlv9Kp7ZRSgC61/TlTD8YG4h7BO
   8=;
X-CSE-ConnectionGUID: AD89X5dbSkSsV/WH+airlg==
X-CSE-MsgGUID: mbrfXLYRTQC0KR4DMIHCRQ==
X-IPAS-Result: =?us-ascii?q?A0A1AwDd3y9lmIMNJK1agQklgSqBZ1J4AlkqEkiIHgOFL?=
 =?us-ascii?q?YZAgiMDkleLJIElA1YPAQEBDQEBOQsEAQGFBgKHFAImNAkOAQICAgEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAgEBBQEBAQIBBwQUAQEBAQEBAQEeGQUQDieFaA2GTAEBAQEDE?=
 =?us-ascii?q?hUTBgEBNwEPAgEIFQMeEDIlAgQOBQgaglwBgl4DARCnBAGBQAKKKHiBATOBA?=
 =?us-ascii?q?YIJAQEGBAVJewGxJwmBSIgKAYoGJxuBSUSBFYMrPoJhAQECgTYoLAyGC4N2h?=
 =?us-ascii?q?H88BxQEGoIigno1KoEUiXleIkdwGwMHA4EDECsHBC8bBwYJFhgVJQZRBC0kC?=
 =?us-ascii?q?RMSPgSBZ4FRCoEGPw8OEYJDIgIHNjYZS4JbCRUMNE12ECoEFBeBEgRqHxUeE?=
 =?us-ascii?q?iUREhcNAwh2HQIRIzwDBQMENAoVDQshBRRDA0cGSgsDAhwFAwMEgTYFDR4CE?=
 =?us-ascii?q?BoGDicDAxlNAhAUAx4dAwMGAwsxAzCBHgxZA2wfNglMA0QdQAN4PTUUG22cW?=
 =?us-ascii?q?G2CIiYgexMBKyKBYi4LOpJ/gmMBjBSiYgqEDIwBlR5JA4NrgVaSC5IImDyLG?=
 =?us-ascii?q?YJMiHGMRYULAgQCBAUCDgEBBoFjOoFbcBWDIgkWMxkPjjmDX4RZgTw8iSh2O?=
 =?us-ascii?q?wIHCwEBAwmIb4JbAQE?=
IronPort-PHdr: A9a23:JlYbLxDLjfghbtwNfbF/UyQVoBdPi9zP1kY98JErjfdJaqu8us6kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+iLzKlBbTf73fEaauXiu9XgXExT7OxByI7H8H4/ZksC+zMi5+obYZENDgz/uKb93J
 Q+9+B3YrdJewZM3M7s40BLPvnpOdqxaxHg9I1WVkle06pK7/YVo9GJbvPdJyg==
IronPort-Data: A9a23:2s6oNKqwr0jl51bLd+6s0Q8t0npeBmLOZRIvgKrLsJaIsI4StFCzt
 garIBmAOPeJNmHwc4t0bt+28xlTvpTSx9NlSVY/ri4yQXhB9+PIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7wdOCn9T8ljf3gqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYATNNwJcaDpOsPvb8UM35pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86rIGaRpz6xE78FU7tJo56jGqE4aue60Tum1hK6b5Ofbi1q/UTe5EqU2M00Mi+7gx3R9zx4J
 U4kWZaYEW/FNYWU8AgRvoUx/yxWZcV7FLH7zXeXmODDnn2bf3HXwM51MgYJHc4R+/xzDjQbn
 RAYAGhlghGrjuayxvewTfNhw51lJ8jwN4RZsXZlpd3bJa95GtaYHeOTvpkBh25YasNmRZ4yY
 +IQbDtkcRDJeDVEO0wcD9Q1m+LAanzXKm0B8wLF/fJri4TV5Al7yrbdFOvvRuWhHeZvwmq9h
 0LtxV2sV3n2M/TGmWbarRpAnNTnhz7gRMccE6f98v9snU272GMeElsVWEG9rP3/jVSxM/pbK
 koJ6m8gtqQ/6kGvZsfyUgf+o3OeuBMYHd1KHIUHBBqlw67Q5UOSAXIJC2cHY909v8hwTjsvv
 rOUoz/3LRVD4OylFH6XzbSvtg31BghWJG4YYSBRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai8XdWa1I70JFj6kmrwbzUq2n3/8SUF2bZ8i2SDz39sFIoDGKwT9HwgWU3+8qsO2pworOpk
 HUCh8+YhAzlJc7TznXVKAnh8U3A2hpoGDTYhVgqFJ47+nH0vXWiZotXpjp5IS+F0/romxe3O
 yc/WisIu/e/2UdGi4csM+pd7Oxxk8Dd+SzNDKy8Uza3SsEZmPW71C9vf1WM+GvmjVIhl6oyU
 b/CL5fzUChFVfg5lWrnLwv47VPN7n1vrY80bc6jpylLLZLFDJJoYe5faQDXPrxRAF2s+VyPr
 76zyPdmOz0GALGhPUE7AKYYLEsBKjAgFIvqpslMHtNv0SI4cFzN/8T5mOt7E6Q8xvw9vr6Rr
 hmVBBQCoHKh3iKvFOl/Qi05AF8Zdcwh/StT0O1FFQvA5kXPlq71svdHLcVuIOl8nAGhpNYtJ
 8Q4lwy7Kq0nYhzM+i8Wat/2q4kKSfhhrVjm0/aNCNTnQ6Ndeg==
IronPort-HdrOrdr: A9a23:4QxTkKsebodQenDy8Gw/qLkQ7skCCoAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwSZVoIUmxyXZ0ibNhRItLxGHdySWVxfJZnPvfKlrbamzDH49mpO
 hdms1Feb/N5DdB/LvHCWWDYrEdKZy8gd6VbITlvjdQpGNRGt1dBm5CY27xfDwSNW177NgCZe
 WhD6F81kKdkAEsH76G7w4+LpP+TrPw5fTbSC9DLSQKrCOJijSl4qP7FR+34jcyOgkk/Z4StU
 L+v0jc/KuMj9GXoyWw64bU1ftrseqk7uEGKN2Hi8ATJDmpoB2vfp5dV7qLuy1wiP2z6X4x+e
 O84SsIDoBW0Tf8b2u1qRzi103LyzA18ULvzleenD/KvdH5fjQnEMBM7LgpNycxqnBQ+O2U4p
 g7mV5xhKAnVC8oWx6Nv+QgYisa0XZcZ0BSytL7wUYvC7f2I4Uh3rD3tHklYqvoWhiKq7zO1I
 JVfZ3hDDE8SyLGU1nJ+mZo29CiRXI1A1OPRVUDoNWc13xMkGl+1FZw/r1Uop4szuN0d3B/3Z
 WODo140LVVCsMGZ6N0A+kMBcOxF2zWWBrJdGafO07uGq0LM2/E78ef2sR42Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmJlG6ArETmmxVSnkjste+596sLvhQ6eDC1zPdHk+18+75/kPCMzSXP
 i+fJpQHv/4NGPrXZ1E2gXvMqMiYEX2kPdlzOrTd2j+1f4jcLeaw9AzWMyjUIbQLQ==
X-Talos-CUID: 9a23:N9n0/mDVC8p/rC36EwBLpB8kR8wvSX7m10mXHG/7AGdzTLLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3A7y17FgzCt1Ik3KnjZNdKrcOY2oiaqKGkEk49taQ?=
 =?us-ascii?q?8h/CvbQ9KZxu4rRSceLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-1.cisco.com ([173.36.13.131])
  by alln-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:40:10 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	by alln-core-1.cisco.com (8.15.2/8.15.2) with ESMTPS id 39IDe7lL017203
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 13:40:10 GMT
X-CSE-ConnectionGUID: jqzO5Z+FSa+kJRXkLVI1fA==
X-CSE-MsgGUID: /mKrw47zRxuwML92bx5p2A==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,235,1694736000"; 
   d="scan'208";a="5174216"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:40:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZtWRJBEeIhREi46ae7vZ9/VkK3xO6hmBOC1/qBscF0FMHcUToIckOOJQQ+wH5E9lTsdqAl+NaKYrloCW7Td+aGr4OhYV2+0sLPj4sdxJgpEdhYcyr0UzMCyV7xs/DLtajW8UqAmOzP6vqxzatoG7IvNEMzGG3yqelMOclFucrEbEPQoypdRs4YPVqXU8gSF2FpWPUdv3LqXF5yWvVDeY/w6NeuRT7p7AH1ya+V12B1wEzgaC/7/7PKn+MQIJbGTUlOWBvcblTP39+mxwCZ/HXbkKyei3untjpr10QMUKA8/AgZ+xQAee/uyQE82Cpxmf/6/v3Hv4NYHQIvvyMeU6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cNeg3t5lkLQUIWqXXHEdf/im3bp86FEMFBzVuh2hjc=;
 b=kvmOVM820lSHYhRLoYRyTk1TR4W9Nw9DGn/MdL6R+iMacHN6dZ9n1O7I3Kxbty2jdJbfAJeLJYd0nvG5pDfc6XKqbF8+6iQCMcBLLiJ9Wyb5WBMFMQVkdBixit9OI08We7DFsRG040TmOFgwXkqRSbe1NDhwmYmwn6nvoiVzYeeNU2xdGiK4qnaSimUmLssdw8Bc0IyPW7vOWaj3rgzdJaN769nUbr2MJuQutFOmiZZwG6/XJemYfDeu5LVJYTaPscocSkawcnBf3MsRHOA8NJ9E9d9NEnCSf6jhRSDQgMCy646sXRBcEzefLpGcLi/Ug7zxhUkTm6NycRePDiQdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cNeg3t5lkLQUIWqXXHEdf/im3bp86FEMFBzVuh2hjc=;
 b=LA34Q5J3F6ZpI2/e9fKxCptRmZk5V/z1IhJAcO+xCl6fzQBO744pxZed6sFSzkL6GCCSgX6rNTTFvrkM0QJWsP0o33Vrvq37noTwKNr7WA9Ucg0f5zD5/QYI0/er7XcnP65ZXQOpAqd4dB4+i9s5Qpf35clR+n2vUjGMIboJvIA=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by CH3PR11MB7868.namprd11.prod.outlook.com (2603:10b6:610:12e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Wed, 18 Oct
 2023 13:40:03 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9%7]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 13:40:01 +0000
From: "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet
	<kent.overstreet@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        Wedson
 Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Thread-Topic: [RFC PATCH 00/19] Rust abstractions for VFS
Thread-Index: AQHaAciXnZKobs/TAU2550HvQLRRhA==
Date: Wed, 18 Oct 2023 13:40:01 +0000
Message-ID: <fglmouoerwv2wedf5kmfyggalcs5hbdhru5ms4jqftlie6ta5a@2726hqdlcste>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
In-Reply-To: <20231018122518.128049-1-wedsonaf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|CH3PR11MB7868:EE_
x-ms-office365-filtering-correlation-id: fcaf0d34-221b-4760-53bd-08dbcfdfba70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jgHZ0Hf8poqO9UQODbevn4bKFkVJkkPR96byBjG3vBlb/NnCwVQCydYasZGJnl7DF44uLLpIIju7VVAHEfLb2NZrZ82Y7ZtO4UZU7q4zqAQSRmkSZal1BlVk/P7CV3y42CJGqmUt+24IKE2etllq3mNhgaadSB2DsNNOsw2VycQW6hZIiYsZkZmhWvxLEldNueN/jzl+5YuRLw/fcuFlCewRReA7Ma5o6CAR3og6/t++MrB1O09hWOlg6/fsqDcMRNzvglSikblo9UvDlPaJMVskpCUkb0Z4+UjeykRwp5Lfcxz5xA+RGRNbFe+unIyf+8h2D3ACls2cb85oOKaoN4YbZrYfdCTjX1U9UT2SctIt/Wmba6ez/QNEPtuAn2+dnpURPVmWsu23sfPdSxLqMckVUy5zOjKbsKEe9wNpFayjFUfsR07Z5DYhYoOuOh6iEM5AraZaRWgKs2PkiBRDznfwgXS5IM6DKEkETG75YxmNmBRTd2R6U0UX2WD+e7HZ7uDz7UnOITBSY0AzQSaXtIEEAyXKp39bM4nGkBObBqi8t9g4iztY/lEtm9EVkQ+7gymHZQ5Bq2gjQqPBODHL/UGQa+yOgWRi34l5BKJmAfA/oZq9Qd2kaWp12BR0bxE/PGeU3QWhUeS8iQvnUzTCfw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(5660300002)(966005)(6506007)(8936002)(8676002)(83380400001)(2906002)(66946007)(41300700001)(76116006)(91956017)(66556008)(66476007)(54906003)(66446008)(6916009)(64756008)(316002)(122000001)(86362001)(4326008)(478600001)(33716001)(9686003)(38070700005)(38100700002)(6512007)(26005)(71200400001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PXdIwPktq2qzAg/nVA5A06zlqYXHqYeKe624OWBygC20ADkAFEsJpLthRlvD?=
 =?us-ascii?Q?juDzFY7lJKjh9GAEGUzJ3vGkhr2lAd1qpNQ4t6l1etKBthMtL+Gt30hnCb5X?=
 =?us-ascii?Q?ToZ1q7P+G6BEMHdF5BA2Dd2Mr34K1LiCjPmFJ9oE2tkTUTOzMAzBZ7T3p7Vm?=
 =?us-ascii?Q?ahHNWm2VA6+9WkAkkDkCr7MzAD9sLjY+sjLXkhCyR9eTG3/255k0F62rD8Pl?=
 =?us-ascii?Q?x2JoOKV4YBX8+VFNQnl6rdnCqBfnta3FI1k9Dv3BNqPLLRXtBWG9LEcLwn/Z?=
 =?us-ascii?Q?lyEm3UjADlLcMNHHNzHaX+ppvfnnVLnNZpIQ1gaS1e3glZkTPBrcuigo3FCW?=
 =?us-ascii?Q?DDdVAecoeJL7D1O9PRJ4St2xVghJTs7qu2LN462lfiAUZwoTTuiaQo6kTo+h?=
 =?us-ascii?Q?7IuNMw0uEGWNwzM04yJsgF/nOFv1NIwcUUUl7WGuYG2/Xow2PDc/tvy4rzpA?=
 =?us-ascii?Q?A4cmIWpz6CtvfIJAGrglXKfw6nCPmrl4tMFdHfc2tWokW2SA/lnjjimbu5+v?=
 =?us-ascii?Q?qd7uaPlPL+vfaG0waU+qjSFYADcPBNBoTn5IrfYq6xFlm46W14UISnCm9O4h?=
 =?us-ascii?Q?JrQQYLo8JGhkx87cucaPl84dZL8LoC1mV+DTuaS/lHc8F1UEbyaI9/DjMnsc?=
 =?us-ascii?Q?zg7NWKRmhxZ0yhFDW/mFH1Vu9zy3CiiksW5LmQiopESv40yZyEGWMeyFH/R/?=
 =?us-ascii?Q?ASffwoBKDDG6M7JTIU6iUWzM7C0hOB5dByJ6N3MgfFoOQyNwlYy7znsozWEF?=
 =?us-ascii?Q?0Rr5we9zpkzLaM4vXgYS8Feesad6IQeJFjt3Y1zKFbo1nDa5Fm0NpwJpyvPQ?=
 =?us-ascii?Q?kX8derC7zLZaXMkiQzDzBZ1VPSqYkoIkkuRoVyf2fKNDELeS7P3nPod3L+bo?=
 =?us-ascii?Q?EcCpXs6norvICFYacii6xhIAT65eoDw7xJEzH4lqRyMJGrum3sND/03nNX1+?=
 =?us-ascii?Q?AyDmZlc0UnusD/gN++bu52ypL6/fDffdwGUUIHbvnJ9oolcDyMhv8VtN5Q40?=
 =?us-ascii?Q?WUtRaUgQNut+oS9hmV5mF4jl2lZ6ftYtxU3EQH0r6bNrznagdsleVIzkv2x3?=
 =?us-ascii?Q?vZMBd41dDdk1PGyF+cFHUJSpGgOFMRdo+d4V1enltquqsv33kG0N2WmgbZsI?=
 =?us-ascii?Q?sUB0OTX0m15aoAbgZNQiU7SFtcmj6BJQLkGgHJsYaRRa50p5vKlkgdv6i9CC?=
 =?us-ascii?Q?/RKNszrikC4Q1xeXcSDnEfYaT3doJCgIr/VMyUxV05m4x+JRCq5AMgyGa8cC?=
 =?us-ascii?Q?W2TrMsZmZd7S88bx4SV5w7W8+2wLe5BcpzMgGPu1g74SgAQa+UvP6JOknxYB?=
 =?us-ascii?Q?JmRxyZrJavKg/iOhJKSANs4245qZdAENEMoZkEtLsECjC4Qb/vNvotPXWfpK?=
 =?us-ascii?Q?59veRHh+Q/Gu04JIlfigbEUDXnHngZWUsSDRpMdNV67O7AvNIEBCTdAgmsWP?=
 =?us-ascii?Q?F55ozrPnqIF9kaOYhUNuBzIYdli7BaCn5lq2sE5I78cdxe4cPzDRnoJ35fJ1?=
 =?us-ascii?Q?PnjJR259GHLeR29ZGPzWOx2FVJQ5Q5lkGmcNzUYUekNWFnsqE+Z8bdpW+giK?=
 =?us-ascii?Q?nYC1D5NxzEC3uZ4tAS/YSdt7brPhyDnEOlpmtmdR?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77CDEA352A647E49846C622FB3A1051B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaf0d34-221b-4760-53bd-08dbcfdfba70
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 13:40:01.5582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QYU6g4KFDO3NLl3kvzTvYnQKlZ7R06fSAH5hcjtj+R//KgFOVvEW6ZV/wrdiCvnLmJPF9QuXRS7hVnOUYC4qDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7868
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: alln-core-1.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/10/18 09:24AM, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This series introduces Rust abstractions that allow page-cache-backed rea=
d-only
> file systems to be written in Rust.
>=20
> There are two file systems that are built on top of these abstractions: t=
arfs
> and puzzlefs. The former has zero unsafe blocks and is included as a patc=
h in
> this series; the latter is described elsewhere [1]. We limit the function=
ality
> to the bare minimum needed to implement them.
>=20
> Rust file system modules can be declared with the `module_fs` macro and a=
re
> required to implement the following functions (which are part of the
> `FileSystem` trait):
>=20
> impl FileSystem for MyFS {
>     fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self:=
:Data>>;
>     fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
>     fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result;
>     fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Sel=
f>>>;
>     fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
> }
>=20
> They can optionally implement the following:
>=20
> fn read_xattr(inode: &INode<Self>, name: &CStr, outbuf: &mut [u8]) -> Res=
ult<usize>;
> fn statfs(sb: &SuperBlock<Self>) -> Result<Stat>;
>=20
> They may also choose the type of the data they can attach to superblocks =
and/or
> inodes.
>=20
> There a couple of issues that are likely to lead to unsoundness that have=
 to do
> with the unregistration of file systems. I will send separate emails abou=
t
> them.
>=20
> A git tree is available here:
>     git://github.com/wedsonaf/linux.git vfs
>=20
> Web:
>     https://github.com/wedsonaf/linux/commits/vfs

I've checked out your branch and but it doesn't compile:
```
$ make LLVM=3D1 -j4
  DESCEND objtool
  CALL    scripts/checksyscalls.sh
make[4]: 'install_headers' is up to date.
  RUSTC L rust/kernel.o
error[E0425]: cannot find function `folio_alloc` in crate `bindings`
     --> rust/kernel/folio.rs:43:54
      |
43    |           let f =3D ptr::NonNull::new(unsafe { bindings::folio_allo=
c(bindings::GFP_KERNEL, order) })
      |                                                        ^^^^^^^^^^^ =
help: a function with a similar name exists: `__folio_alloc`
      |
     ::: /home/amiculas/work/linux/rust/bindings/bindings_generated.rs:1731=
1:5
      |
17311 | /     pub fn __folio_alloc(
17312 | |         gfp: gfp_t,
17313 | |         order: core::ffi::c_uint,
17314 | |         preferred_nid: core::ffi::c_int,
17315 | |         nodemask: *mut nodemask_t,
17316 | |     ) -> *mut folio;
      | |___________________- similarly named function `__folio_alloc` defi=
ned here

error: aborting due to previous error

For more information about this error, try `rustc --explain E0425`.
make[2]: *** [rust/Makefile:460: rust/kernel.o] Error 1
make[1]: *** [/home/amiculas/work/linux/Makefile:1208: prepare] Error 2
make: *** [Makefile:234: __sub-make] Error 2
```

I'm missing `CONFIG_NUMA`, which seems to guard `folio_alloc`
(include/linux/gfp.h):
```
#ifdef CONFIG_NUMA
struct page *alloc_pages(gfp_t gfp, unsigned int order);
struct folio *folio_alloc(gfp_t gfp, unsigned order);
struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *=
vma,
		unsigned long addr, bool hugepage);
#else
```


>=20
> [1]: The PuzzleFS container filesystem: https://lwn.net/Articles/945320/
>=20
> Wedson Almeida Filho (19):
>   rust: fs: add registration/unregistration of file systems
>   rust: fs: introduce the `module_fs` macro
>   samples: rust: add initial ro file system sample
>   rust: fs: introduce `FileSystem::super_params`
>   rust: fs: introduce `INode<T>`
>   rust: fs: introduce `FileSystem::init_root`
>   rust: fs: introduce `FileSystem::read_dir`
>   rust: fs: introduce `FileSystem::lookup`
>   rust: folio: introduce basic support for folios
>   rust: fs: introduce `FileSystem::read_folio`
>   rust: fs: introduce `FileSystem::read_xattr`
>   rust: fs: introduce `FileSystem::statfs`
>   rust: fs: introduce more inode types
>   rust: fs: add per-superblock data
>   rust: fs: add basic support for fs buffer heads
>   rust: fs: allow file systems backed by a block device
>   rust: fs: allow per-inode data
>   rust: fs: export file type from mode constants
>   tarfs: introduce tar fs
>=20
>  fs/Kconfig                        |    1 +
>  fs/Makefile                       |    1 +
>  fs/tarfs/Kconfig                  |   16 +
>  fs/tarfs/Makefile                 |    8 +
>  fs/tarfs/defs.rs                  |   80 ++
>  fs/tarfs/tar.rs                   |  322 +++++++
>  rust/bindings/bindings_helper.h   |   13 +
>  rust/bindings/lib.rs              |    6 +
>  rust/helpers.c                    |  142 ++++
>  rust/kernel/error.rs              |    6 +-
>  rust/kernel/folio.rs              |  214 +++++
>  rust/kernel/fs.rs                 | 1290 +++++++++++++++++++++++++++++
>  rust/kernel/fs/buffer.rs          |   60 ++
>  rust/kernel/lib.rs                |    2 +
>  rust/kernel/mem_cache.rs          |    2 -
>  samples/rust/Kconfig              |   10 +
>  samples/rust/Makefile             |    1 +
>  samples/rust/rust_rofs.rs         |  154 ++++
>  scripts/generate_rust_analyzer.py |    2 +-
>  19 files changed, 2324 insertions(+), 6 deletions(-)
>  create mode 100644 fs/tarfs/Kconfig
>  create mode 100644 fs/tarfs/Makefile
>  create mode 100644 fs/tarfs/defs.rs
>  create mode 100644 fs/tarfs/tar.rs
>  create mode 100644 rust/kernel/folio.rs
>  create mode 100644 rust/kernel/fs.rs
>  create mode 100644 rust/kernel/fs/buffer.rs
>  create mode 100644 samples/rust/rust_rofs.rs
>=20
>=20
> base-commit: b0bc357ef7a98904600826dea3de79c0c67eb0a7
> --=20
> 2.34.1
> =

