Return-Path: <linux-fsdevel+bounces-1195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0FA7D7144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACDD7B212A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 15:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648612E623;
	Wed, 25 Oct 2023 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="CMG7H6+U";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YrCwPVoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D61DA5B;
	Wed, 25 Oct 2023 15:51:24 +0000 (UTC)
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD26189;
	Wed, 25 Oct 2023 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7267; q=dns/txt; s=iport;
  t=1698249082; x=1699458682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lCKjMLUJdUP3EFoFHy18LFUezCTt/2c92MD7lZk2rQM=;
  b=CMG7H6+U9UxsKC65ibqPS2sTzL+wABepQOVDvkW8IWIzyfno5gU6FAq8
   LYYUPmOIOgBjvvd1BlQN0OZzPRtDl2VSQK3zQXs+n+KuWZ4tDBW+or0ge
   UQA4YKtze8p73vwwzE6bsa5Nk5S8n+CylhBmcI/hgIttH5VaGcW+gSd8C
   s=;
X-CSE-ConnectionGUID: K+4WcsqVQp2U7K13/AGXxA==
X-CSE-MsgGUID: ogQThVdeRVWyrMLVhc9ucw==
X-IPAS-Result: =?us-ascii?q?A0DzAgAdODllmIoNJK1aHgEBCxIMQCWBHwuBZ1J4AlkqE?=
 =?us-ascii?q?kiIHgOFLYZAgiIDgRORRYslgSUDVg8BAQENAQExEwQBAYUGAocYAiY0CQ4BA?=
 =?us-ascii?q?gICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBBQBAQEBAQEBAR4ZBQ4QJ4VoD?=
 =?us-ascii?q?YZMAQEBAQMSCwoTBgEBNwEPAgEIFQMeEDIlAgQOBQgaglwBgl4DAagGAYFAA?=
 =?us-ascii?q?oooeIEBM4EBggkBAQYEBUmyIwmBSIgKAYoGJxuBSUSBFYE7gTc4PoJhAoFgh?=
 =?us-ascii?q?kODdYU8BzKCIoMvKYETinteI0dwGwMHA4EDECsHBC0bBwYJFhgVJQZRBC0kC?=
 =?us-ascii?q?RMSPgSBZ4FRCoEDPw8OEYJCIgIHNjYZS4JbCRUMNU12ECoEFBeBEQRqHxUeE?=
 =?us-ascii?q?iUREhcNAwh2HQIRIzwDBQMENAoVDQshBRRDA0QGSgsDAhoFAwMEgTYFDR4CE?=
 =?us-ascii?q?BoGDScDAxlNAhAUAx4dAwMGAwsxAzCBHgxZA2wfNgk8DwwfAjkNKyQDRB1AA?=
 =?us-ascii?q?3g9NRQbbZ4ugk0gL0wJCgGBMBRrHBIcknA5gmMBjBiiYQqEDIwBlR9JA4Nrk?=
 =?us-ascii?q?2GSGB6YHpZWjEaFDAIEAgQFAg4BAQaBYzqBW3AVgyIJSRkPjiAZg1+EUYFEi?=
 =?us-ascii?q?WR2OwIHCwEBAwmLSgEB?=
IronPort-PHdr: A9a23:0JEZxB9LJnaHw/9uWO3oyV9kXcBvk6//MghQ7YIolPcSNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqPA90LfnxE5X6hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:zmzbWaybtJY+ew1otEZ6t+fgxirEfRIJ4+MujC+fZmUNrF6WrkUGy
 DMfCzyDPPbfNzamL48nYYng90oBv5KAzNIyS1Ru+FhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlpCCea/lH0auSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 YiaT/H3Ygf/gGcsaD9MscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE88jmSH
 rurIBmRpws1zj91Yj+Xuu+Tnn4iHtY+CTOzZk9+AMBOtPTtShsaic7XPNJEAateZq7gc9pZk
 L2hvrToIesl0zGldOk1C3Fl/y9C0aJu2/ybHnOkqPKq1xf7LFi1mLJHI3EmFNhNkgp3KTkmG
 f0wITQJaFWIgPi7he/9Qeh3jcNlJ87uVG8dkig/lneCU7B/GtaaGPWiCdxwhF/cguhHGPfVe
 s4QchJkbQ/LZFtEPVJ/5JcWxb332SOvL2AIwL6Tja042lTT8gB86obSIcDwXuKKTpRIlVnN8
 woq+EygUk1Fa7Rz0wGt6G+3mqrBmjm+XIMUCa2Q6PFnmhuQy3YVBRlQUkG0ydG9i0ijS5dRM
 EAZ5CcqhbY9+VbtTdTnWRC85nmesXYht8F4Guk+7kSGzbDZplvfDWkfRTkHY9sj3CMredA0/
 nzKw+ziHiVRiaXPdC2+r+zThByCKQFAeAfuehQ4ZQcC5tDipqQ6gRTOUstvHcaJYjvdRGCYL
 9ei8XdWulkDsSIY//7gpAya2lpAsrCMH1FtuFSGNo6wxl4hDLNJcbBE/rQyARxoAIufUl6H1
 JTvs5fAtrlWZX1hedDkfQngNLit4/DAOzrGjBsyWZIg7D+qvXWkeOi8AQ2Sxm83aa7omhewP
 Sc/XD+9ArcPZhNGiocsMuqM5zwCl/SIKDgcfqm8giBySpZwbhSb2ypleFSd2Wvg+GB1z/BvY
 MjBK5rwXSZAYUiC8NZQb7lEuVPM7n1vrV4/ubigp/ha+ePEPSXMGett3KWmN7xgsstoXzk5A
 /4GZ5fVlH2zocX1YzLc9sYIPEsWIH0gba0aWOQJHtNv1jFOQTl7Y9eImOtJU9U8w8x9yLySl
 lnjARAw9bYKrSCdQel8Qio9OOqHsFcWhS9TABHAyn73iyF9PNz+svZ3mlleVeBPydGPBMVcF
 pEtU86BGf9IDD/A/lwggVPV9eSOqDzDadqyAheY
IronPort-HdrOrdr: A9a23:9izDLKxafh0sI324iEfgKrPxUOgkLtp133Aq2lEZdPULSL36qy
 n+ppQmPEHP6Qr5AEtQ6OxoWJPtfZvdnaQFmLX4pd+ZLUfbURiTXfFfBOzZsnzd8kzFh6FgPM
 JbAspD4bLLfCVHZKrBkW6F+pMbsae6GcOT9KfjJhVWPH1Xgshbhm8TZHf/YylLrUt9dOUE/f
 Gnl7J6Tk+bCA4qh7OAdwI4tob41rv2vaOjSyQrQzQg7w6Dhy6p7rnVLzi0ty11bxp/hZ0Z3S
 zgiQLW2oWP2svX9vbb7QDuxqUTvOGk5spIBcSKhMRQAC7rkByUaINoXKDHlCwpocm0gWxa0u
 XkklMFBYBe+nnRdma6rV/GwA/7ygsj7Hfk1BuxnWbjm8rkXzg3YvAxwL6xMyGpr3bIjusMlp
 6j7Fjp7qa/yimwxBgV0uK4EC2CUHDE+kbK39Rj1UC3GrFuG4O55bZvjn+9Vq1wXx4TLOscYb
 VT5Aa23ocKTXqKK3/epWVh29qqQzA6GQqHWFELvoiP3yFRh20R9TpT+CUzpAZJyHsGcegO28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBRbBKnibL1jrHLwOfyulke+63JwloOWxPJAYxpo7n5
 rMFFteqG4pYkrrTcmDxodC/BzBSHi0GT7t1sZd7Z5kvaCUfsunDQSTDFQ118ewqfQWBcPWH/
 61JZJNGvfmaXDjHI5YtjeOEqW66UNuJvH9luxLLG5m+Pi7X7ECntarBMruGA==
X-Talos-CUID: 9a23:GpismW+xsLCT6Z2Q6gaVv21XRv8uaWTj9W+KHhCbUD0uYZKlWXbFrQ==
X-Talos-MUID: 9a23:WQsKMQqk4fgVMCNtO8kezzZtDfto3aijMn4ygI8jn/eEPn1tMCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-5.cisco.com ([173.36.13.138])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 15:51:20 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id 39PFpKMq005200
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Oct 2023 15:51:20 GMT
X-CSE-ConnectionGUID: FXUCs7RqSB6KMEeidYhesA==
X-CSE-MsgGUID: nLhkDKhaSp+BRJkKw8ADKQ==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,250,1694736000"; 
   d="scan'208";a="5696294"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 15:51:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr5wUULufqpRhsTIpWlhZRonuE/O+6p0c069qwAsLr+EI5eZHyEglh7iEMMA0h7meDtPpGT0VPHykOqjaKBLqKwIjAJGEDToNF6RwHjix31L5IID8di6G2v2H+BTX/XamB3DXXDSOeDfDCabYTaXHyz4btMIlWyLxUhqYFDwd6zx89SSJtdiUiHssPHeB9e6MlO/eS3PAxaG43oM1CamIB/daSdcs+V580YUASz7NzCvDX8SWbNi5lNCqE5U79UissldiEwAqL6MjoFLGXxsVJhC/eF9YffnEtuI+wxlNN5a9Ss7VlENoO5/2mw72Cyd4ON8DPwcIdH4zT8aoXDTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv17TDTXUFGbC4RS8M7ai1kjpWRD6eqPadHakI64xRI=;
 b=RzdCjdCTIBc9VW42fc81wBIRd0eZf39T6FpfucLRleJtTMed/hU9AsgQGCyKj3HCgLyIPF9NUjsdg5T0BMysuEWbINdwq8445gm9k5snizWiOncYKGvrgW/nod/ayH/hS4vlMf6xNmMC7zSmlWFO/6eWxxkEjjgOe/HZqhh/49i7E6XcX230YKmKevnZ5jeHni0ma0D5lzK8nH5rDi/zlgR2CO6W76gxxpdJaZLkoz5q4NbuxamGxINWCPaGO7DXEbhLmogDoePl7fgAFoV4ulCv7Vcfv0YszaivQ6wd8IGG1ZZ/O+n6HJiqJ9InrDXbF6flwRMZOfCi+vm4AwyQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv17TDTXUFGbC4RS8M7ai1kjpWRD6eqPadHakI64xRI=;
 b=YrCwPVoMd2e8dLp9GLgyQla3obn9LXs6rhicfxEynNADBang6ouy0gSF3TByMDB7GzRR8TMDDWk/xkFV6FtjrtseAVzMaD8c1INwdH8s2MVu5II9wScNjbeIlQZytHmBRwkj0npaxqB0ydmXeVzQsOFWjCUhDAlhzPYDqqfJUW4=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by DM4PR11MB7760.namprd11.prod.outlook.com (2603:10b6:8:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 15:51:18 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::dbd8:84b0:9c4:d12b%5]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 15:51:18 +0000
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
Subject: Re: [RFC PATCH 14/19] rust: fs: add per-superblock data
Thread-Topic: [RFC PATCH 14/19] rust: fs: add per-superblock data
Thread-Index: AQHaB1sXdnRF70b1u0yz1Gv375vewg==
Date: Wed, 25 Oct 2023 15:51:17 +0000
Message-ID: <lzh3l55hgultewxmi3u6ytn7qx3pltn4sesakolvvk4ecpy2rd@7obdythtr5pb>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-15-wedsonaf@gmail.com>
In-Reply-To: <20231018122518.128049-15-wedsonaf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|DM4PR11MB7760:EE_
x-ms-office365-filtering-correlation-id: 0ef98df1-3992-4a33-cb38-08dbd57239fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ar/pvf6FthnT4v+QKz60KmFs+DiIdew8528ccj/8Y7ND/2Yn9zu2nCVVFMgLhMCn1FNKjqJftfhaN7rxKqh+w5NMndlu8hrfJN/shxWrZO7t/twXd14reAWO7Tt/2hwY5IR2LUi4P4vK0IsBEGgarQWAb1TakSNtOhAHxvdtRX88vHoCD+IFCaw/2sx03bzZqwdkdYJWs3EDuGcCbIYnjIZAgl0pNYP6eGDRPqKaNV66VNUnltYMPEk+iTdS0uf+qzV0Q+Irckj1w1GhE6SIV7eBYoqH/z8DvIhXWOzTJPffJ0QsuQBbuSq+L40LcTeXHQUHWXgfsX6CG+ULlIKk7sSqyTlhndxadFOPdt2Km4Sp5JzzWyByVKoeijyBMXK1gWKOLRI9tU/fvS1IHAu+okhUMtWHadQbhAHCzOPsBroLUKCveXfj2f4PRWhEsSM2uMRNyX6aaBgwLcJTcWGRsH6VyILkk0KD+WFFQibm737oSZDNDBB7JN4XZuNAyVht/DU4veQY/3td9tshzdonPoVmIzrMJVfPbGMsPpap+gVHLrcd532OqQjaPD9l1CMcdMMXBJEUEeHJVBTRXHbFmNPsVqx6MHrsbsSuCYH9an1eF5mlPONgZGBPhihIM09A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(2906002)(122000001)(64756008)(91956017)(66476007)(66556008)(54906003)(66446008)(66946007)(6916009)(76116006)(38100700002)(478600001)(6506007)(6486002)(71200400001)(9686003)(6512007)(83380400001)(4326008)(8676002)(5660300002)(41300700001)(8936002)(38070700009)(26005)(33716001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OTxBfh7C8/O6XRZl5BJIkyc8csMmpGNoaIlXYIug/yZ6Kdg7xTmUTRBMSqKm?=
 =?us-ascii?Q?QG0II2G/MOzKnuoCBxwEORa97FW4a20srv44T+I/Mjbs5ROCcBiZgacKAaP7?=
 =?us-ascii?Q?VzbK3ZDLCkbv3ZL2lx4mPdl8yv/HQiFCNOg4wrky3Yq2MpQCdqmX7fM5bWKO?=
 =?us-ascii?Q?4F8uvAxUiPuCRksbmPBHL8pfbSSQNzk8ijO/eRvdsyWBhKSR6Cn9EwOrJtYz?=
 =?us-ascii?Q?wlXkag7+Iq91P7YgN6TGMRGcdwExgPgdfLDdL56C5zN1HdrRLPlbrEaBQqJ8?=
 =?us-ascii?Q?ST8NHfEUA0QXP83bYW5LEYasisi8jIt/cSfHwRh3XV3BQZSQRKPaT4ZaT/mB?=
 =?us-ascii?Q?3rPNTM2m4irEwOc8SCs80uL80KVzBy1FILEwkWZ/bG1tj3tRsCPWB7GI/xG8?=
 =?us-ascii?Q?/S9B53OpY+4c5TV/lmZ0ZZsTh3A9pPp7ToEGGu2QBtT9QqYUxJ/7UK5X7CFM?=
 =?us-ascii?Q?19Lc/oSAHGjr8cuAmu8HcOFnUgDbPnmRPfEeKnrqKxH3R3Nube6NV+V7urM4?=
 =?us-ascii?Q?4VW97zIxWyT685JE3QrqbqRhnb4jjqIRbKcmDPGj38tCH1a4Xp3uy/LEBIKh?=
 =?us-ascii?Q?pUGC3YW77/QxIQ7qc2znu3Xkcu3g91tg4DnVUWEDopcmd+gSsjLF5K7DtmRK?=
 =?us-ascii?Q?WNemZRXqUXiFS0ANTjaj7O5sk+bifNQj5QrLGwZTbdigfQsSDq4FxWXhswBI?=
 =?us-ascii?Q?rWDmewMjagPNsI6NHOb33HhvO9K9QQT5UkBjTkRKq827JZ7EhNSZKTrmpkNN?=
 =?us-ascii?Q?IO2NteCnAjYh2QF1ugleD13iAtvufQqWtjl8xDv3TWBb26GRyYVADtCNz/rC?=
 =?us-ascii?Q?P2ONIOb03S8nDGHmGSLgB6q711U5lFzBZO+2Id1/QS5X+B1ZdK76Tj8WRgpl?=
 =?us-ascii?Q?0pyevpqJJw2TQ/IpzsSWJhl+dyd2OwHoVpYnRA9zW4gT4HIohIyOrTudBNQB?=
 =?us-ascii?Q?Wx58HOt/7MF6JUf6rMVM3Ef3JO+AKd6LM6VjTcwYfUf0IbjDHssG9VbMo4Hi?=
 =?us-ascii?Q?WGhrUoy6zTbgK/bSrhm5vfs4kg/mz84FG8JT3f3v1kdnve40cpXkGX5g4LNz?=
 =?us-ascii?Q?6mjMW6z22yj7FcncoNg/b3cwQA5n9Ait9z94zoJQFCR8EwJ+FrQNBIN5YRIj?=
 =?us-ascii?Q?LXWMPy3ijGhsGQWD2MFxdNeqgeGbo+gGK3aWEBckLMMdWWTaTD6brnOLugt+?=
 =?us-ascii?Q?Xr2d9dNta7VX+s8ZpXQ7VNiDPsUDhPcPgI7/T1OnKDd+eBAD0R5ho01FvkK0?=
 =?us-ascii?Q?g5GKY5cP2lEa3H1khn1aXBu1VTXEjQ8gTaAZ3m3FtaXvQuf0Uv+0SdWIWt2p?=
 =?us-ascii?Q?q0/EWcq0dePVACF97TJEArx6RJ60WhUCwVDZx1OvAePW/gdP4RyTl/s6+TFQ?=
 =?us-ascii?Q?z+sZuufn/53wTR8MFM0UvMDqzh+AbzwE3yJ4Xy0v0U4iVAk1rbPz7lGGxnmM?=
 =?us-ascii?Q?iOoJ20TWrIjTNJxmKnU/ZuZk3NaDx4ALVgUIiWWfqDsr21zO68E/DrcqLHpE?=
 =?us-ascii?Q?gjSsFzW3aVUKWe5A5yb9/TYoutURQvzrB3//NuU/dZh1imaVzkAYKdrygmns?=
 =?us-ascii?Q?/t1mdb3JV9EmDuzLtru1mkh4voco5tkzqy3+c2iV?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCD37227D15E994DA836D081F6DFD718@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef98df1-3992-4a33-cb38-08dbd57239fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 15:51:17.8793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8c/NYRvITv3YgtgQp/dXL7LdKBjAHKzImUUSAFUBMWvCknr/vCUQp4VnFkVlwNx0MYvpF2fxVE0KHI996fkxgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7760
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: alln-core-5.cisco.com

On 23/10/18 09:25AM, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow Rust file systems to associate [typed] data to super blocks when
> they're created. Since we only have a pointer-sized field in which to
> store the state, it must implement the `ForeignOwnable` trait.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/fs.rs         | 42 +++++++++++++++++++++++++++++++++------
>  samples/rust/rust_rofs.rs |  4 +++-
>  2 files changed, 39 insertions(+), 7 deletions(-)
>=20
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 5b7eaa16d254..e9a9362d2897 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -7,7 +7,7 @@
>  //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
> =20
>  use crate::error::{code::*, from_result, to_result, Error, Result};
> -use crate::types::{ARef, AlwaysRefCounted, Either, Opaque};
> +use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaqu=
e};
>  use crate::{
>      bindings, folio::LockedFolio, init::PinInit, str::CStr, time::Timesp=
ec, try_pin_init,
>      ThisModule,
> @@ -20,11 +20,14 @@
> =20
>  /// A file system type.
>  pub trait FileSystem {
> +    /// Data associated with each file system instance (super-block).
> +    type Data: ForeignOwnable + Send + Sync;
> +
>      /// The name of the file system type.
>      const NAME: &'static CStr;
> =20
>      /// Returns the parameters to initialise a super block.
> -    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
> +    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self=
::Data>>;
> =20
>      /// Initialises and returns the root inode of the given superblock.
>      ///
> @@ -174,7 +177,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static T=
hisModule) -> impl PinInit<
>                  fs.owner =3D module.0;
>                  fs.name =3D T::NAME.as_char_ptr();
>                  fs.init_fs_context =3D Some(Self::init_fs_context_callba=
ck::<T>);
> -                fs.kill_sb =3D Some(Self::kill_sb_callback);
> +                fs.kill_sb =3D Some(Self::kill_sb_callback::<T>);
>                  fs.fs_flags =3D 0;
> =20
>                  // SAFETY: Pointers stored in `fs` are static so will li=
ve for as long as the
> @@ -195,10 +198,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static=
 ThisModule) -> impl PinInit<
>          })
>      }
> =20
> -    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_b=
lock) {
> +    unsafe extern "C" fn kill_sb_callback<T: FileSystem + ?Sized>(
> +        sb_ptr: *mut bindings::super_block,
> +    ) {
>          // SAFETY: In `get_tree_callback` we always call `get_tree_nodev=
`, so `kill_anon_super` is
>          // the appropriate function to call for cleanup.
>          unsafe { bindings::kill_anon_super(sb_ptr) };
> +
> +        // SAFETY: The C API contract guarantees that `sb_ptr` is valid =
for read.
> +        let ptr =3D unsafe { (*sb_ptr).s_fs_info };
> +        if !ptr.is_null() {
> +            // SAFETY: The only place where `s_fs_info` is assigned is `=
NewSuperBlock::init`, where
> +            // it's initialised with the result of an `into_foreign` cal=
l. We checked above that
> +            // `ptr` is non-null because it would be null if we never re=
ached the point where we
> +            // init the field.
> +            unsafe { T::Data::from_foreign(ptr) };
> +        }
>      }
>  }
> =20
> @@ -429,6 +444,14 @@ pub struct INodeParams {
>  pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_blo=
ck>, PhantomData<T>);
> =20
>  impl<T: FileSystem + ?Sized> SuperBlock<T> {
> +    /// Returns the data associated with the superblock.
> +    pub fn data(&self) -> <T::Data as ForeignOwnable>::Borrowed<'_> {
> +        // SAFETY: This method is only available after the `NeedsData` t=
ypestate, so `s_fs_info`

`NeedsData` typestate no longer exists in your latest patch version.

Cheers,
Ariel
> +        // has been initialised initialised with the result of a call to=
 `T::into_foreign`.
> +        let ptr =3D unsafe { (*self.0.get()).s_fs_info };
> +        unsafe { T::Data::borrow(ptr) }
> +    }
> +
>      /// Tries to get an existing inode or create a new one if it doesn't=
 exist yet.
>      pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<IN=
ode<T>>, NewINode<T>>> {
>          // SAFETY: The only initialisation missing from the superblock i=
s the root, and this
> @@ -458,7 +481,7 @@ pub fn get_or_create_inode(&self, ino: Ino) -> Result=
<Either<ARef<INode<T>>, New
>  /// Required superblock parameters.
>  ///
>  /// This is returned by implementations of [`FileSystem::super_params`].
> -pub struct SuperParams {
> +pub struct SuperParams<T: ForeignOwnable + Send + Sync> {
>      /// The magic number of the superblock.
>      pub magic: u32,
> =20
> @@ -472,6 +495,9 @@ pub struct SuperParams {
> =20
>      /// Granularity of c/m/atime in ns (cannot be worse than a second).
>      pub time_gran: u32,
> +
> +    /// Data to be associated with the superblock.
> +    pub data: T,
>  }
> =20
>  /// A superblock that is still being initialised.
> @@ -522,6 +548,9 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>              sb.0.s_blocksize =3D 1 << sb.0.s_blocksize_bits;
>              sb.0.s_flags |=3D bindings::SB_RDONLY;
> =20
> +            // N.B.: Even on failure, `kill_sb` is called and frees the =
data.
> +            sb.0.s_fs_info =3D params.data.into_foreign().cast_mut();
> +
>              // SAFETY: The callback contract guarantees that `sb_ptr` is=
 a unique pointer to a
>              // newly-created (and initialised above) superblock.
>              let sb =3D unsafe { &mut *sb_ptr.cast() };
> @@ -934,8 +963,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>  ///
>  /// struct MyFs;
>  /// impl fs::FileSystem for MyFs {
> +///     type Data =3D ();
>  ///     const NAME: &'static CStr =3D c_str!("myfs");
> -///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams> =
{
> +///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams<S=
elf::Data>> {
>  ///         todo!()
>  ///     }
>  ///     fn init_root(_sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>=
> {
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index 95ce28efa1c3..093425650f26 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -52,14 +52,16 @@ struct Entry {
> =20
>  struct RoFs;
>  impl fs::FileSystem for RoFs {
> +    type Data =3D ();
>      const NAME: &'static CStr =3D c_str!("rust-fs");
> =20
> -    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams> {
> +    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams<Sel=
f::Data>> {
>          Ok(SuperParams {
>              magic: 0x52555354,
>              blocksize_bits: 12,
>              maxbytes: fs::MAX_LFS_FILESIZE,
>              time_gran: 1,
> +            data: (),
>          })
>      }
> =20
> --=20
> 2.34.1
> =

