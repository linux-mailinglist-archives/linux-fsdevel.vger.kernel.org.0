Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C2E64421C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 12:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiLFL2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 06:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiLFL1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:27:48 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85F5F56;
        Tue,  6 Dec 2022 03:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670326066; x=1701862066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=O1KcbtSxCrjBAP/4bh7L0Hpl7SFI6sQBykyeu4Y9o2ojJrwpoo7Ni4ns
   fi2gslNiO44rRBT6FlCTLSqzjZa6teTQvxkCnZT46Isg0FIFEdsOebNmz
   Ruw+SYN8cwa3kZr2ztDtgbieeqrGXJ14hPzjg6/Y5U0eHwiy3DESU4qQv
   Bo3rbKc+mO6h+U7SponppRHWowG99eLbpa6Mb2l2xITsknWxV6QA7El7e
   3aSPuhgi9zsaLRYDjVHdAkrdqnlsNDY5B6aOTRmhc73Y1ADC51UYccHs5
   4SuFcC7uzriJxnt6kpwjz5L6eS9+BfFRaLx2N075szdwT7dDJRj8ncQ+d
   g==;
X-IronPort-AV: E=Sophos;i="5.96,222,1665417600"; 
   d="scan'208";a="217998328"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 19:27:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zeb1ttc6NeWYpkPm1OU0qb5GATawzs/InMp7xaVNFzB2x+PcC3EgBp5tWegQGut4XD0WnpKGQOrOEtf0Z6n+P6tnU0R5HbKZzarBLGviNz+ZKvGFchXBQvXO/CI99Sr62NR6pLevW29mq12U+sKwYkJCgIDgeUBsH5j/cMdcYg+4M86KOm4r6OUk4owNx7lLMgidkrzrlaKh2gCzMQd3RnF+mCnQoYJj1DWuq9YUT1s9gdlZoPyq1wAX6xQP+RR+/jRD0yuu91um3eHZ/VuPlvHBiP78jGlb6kPistXQBDQRo/3yjZ/X8xqnZAzVjG9e4o9IcYgUcV8NQzc6E+E94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=foQ8oeq00crqpPIRSAP2FP90C43qkXWptkL1apLds5xZ+cnwwPuVazjxfc/lqAQ5pxd3+kUhLQpUGmEHsx2JyiUvrDJWghRj0YHuBx6d8YMC1xj00x7xMkVW9QNCdvS+IJbVJPaXxz7fw77vGHEtKv3IkGOU4ynLr1hjHeWqP4MtHL/0mFxTWER1gE72UrgOh0C9vgR1HsbPAxM7siLabB9vIr5gYstuZmJCJur4kt+GTaHSVIy0IESuLweFZbN06qRpxWN6zt5awO5FOnuB/i6D6J5rerrt+Dy9eIdk4BDcwuxeD+Lt3tlv4vv3Eoux7rE6cKFouLGEAI2RyT2eDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=aSxZM7zQPKHnnha9OF4wk4JRiSQAZqkHhDc1A1f8axPpoWXES1PQ3FZvdhpJCnDqeXZFqOpzmm+Lz7kglbLF0r2ZCFSq8gVkmq3cG1AukBG02ZcalN615NckM0biG41XI7QIktysCc0uQiwtJokxOtlVXcBAHlIc4MedO61ByE8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7979.namprd04.prod.outlook.com (2603:10b6:208:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:27:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:27:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/19] btrfs: pass the iomap bio to btrfs_submit_bio
Thread-Topic: [PATCH 09/19] btrfs: pass the iomap bio to btrfs_submit_bio
Thread-Index: AQHY/N5Z0usuSJxuM0+otrkUKuAYdK5g0cSA
Date:   Tue, 6 Dec 2022 11:27:41 +0000
Message-ID: <5f3e7d2d-c440-bcab-7ce6-5e2286583c6b@wdc.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-10-hch@lst.de>
In-Reply-To: <20221120124734.18634-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7979:EE_
x-ms-office365-filtering-correlation-id: 648bf7b0-e6a7-4525-4dfc-08dad77ce384
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6/cE+2mItonPezMaDSVazFk58JRUa+FyQTygF7BTcwDYSpDcltbkzDmbZocOrxTWNpvBuonGvwFotpIC33ZOsEPEoef001U0nr740S8bgKDxGV4+afyJnznWsWp+wli165jK+aycMwq8wErmIaP6V+ndnnNnC7qFu+EBaBRmb/DjFl7cHSapOaQvIV/eqjd4nygijz3AXic5EQaF0bO0LAOTzgNzdePhXcmMxpJeoAMTu2I+gzxPHrjlL6jIt2hlZHDVFl2g2QOr/QJDeU5dh+YNpzl6RbFCc9y2ma9HS2YlVrqEybj1Q5QdZG0ssBlJXdcmQBgX74WlZ4lvEqfQA3MT58/z9rcUmu82tAvaNmDr7Scy66BsZr+PjZosW00pjoGpYMCNkOz5GT3vLASUibPKD7d065DZtjz8Te94VoQetfxGG4zE9+1rjGvIL2Uo/X84kvA3tVeC6qRLXHxq7Dsr4bBkEr1ncPy7m0tXpcyrdwFR7GM50vIBTqfDl/tgKD+Tt9LOWha3SuJRGhByP1cnADZzApVzaIP9P3F9Oz66roXbVtlHQC54XTl50ZiAxIdqoSsfHrgEJQ3qRzvEgIM2ANTYmA4amFrLiqS8rNXaTYeTwKENA97z5P/JwcUf0ZL/uM2pBv16frDtFKMcHlJjte34GsAHyVmUNk/iU9M4VsK3S0AH7SYsBhjjGZr/0K/WUdGRHiPcQDq/ZJqTo7la5CciVCo1yPNb1BokftgCh/e73cCgmZvRj44ZeA7LqiGyPpvcKFs8xeE6sy55g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(122000001)(558084003)(86362001)(31696002)(8936002)(82960400001)(5660300002)(38070700005)(7416002)(4326008)(2906002)(19618925003)(41300700001)(478600001)(8676002)(186003)(64756008)(6506007)(6512007)(110136005)(66946007)(2616005)(66556008)(66446008)(6486002)(91956017)(54906003)(4270600006)(316002)(76116006)(66476007)(38100700002)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTZieGo2MmtSaXZ2azY2UXNZZVFiMlFyYmVNcWQzS0c4eWtjZ2pMQldLempx?=
 =?utf-8?B?N2ZzTExnaG1RZ1lacXEzNnZYNnBSL2RMZ20vYTRZTVhVQlZnL1pVRU8xUEJm?=
 =?utf-8?B?N25pOHdQVmJldTk2bzV6NGgwV0pTRWU5Z2dvVUpDRjBJRmhmSHJMM05DWDhs?=
 =?utf-8?B?citnQVhoQ1dRcU5GMzUxR1IvZnM4UXhFbG9GZ1R0dFhoTEo0ZE16RkxpZVpH?=
 =?utf-8?B?VW54MHdjSzNRYWYwSlJ6NTkyVVFWei9DcmtkMjVYaTg3RXJVZ3Q2anhkalpk?=
 =?utf-8?B?QkxjZ2lOeDhOTnkxYTlCaVFZSEx3bUh4bU50UFM0TjM5d3AyZ3RRclE4WGVa?=
 =?utf-8?B?dlptNnJJa0l3N1ljUnA2emswMmJYbFYyQ1NLSFpTYWtBSzh5K3RUeW8xMTc4?=
 =?utf-8?B?bXpIanVIZ25FOTRkWU5GZVFkdTlRdjlaWXFCeHV2REEwaUpRWEpySjBFbUpw?=
 =?utf-8?B?T2c5K0prTGlhb3RUQ01QakdhNDNGSUNtay9SbFRuSzRUMzh4Zis0Tmxkd0lx?=
 =?utf-8?B?aCtQanBVa1k3c2lWWUU0YlUzaWE2Q3MyQ1dwMHBXZzd4Q2FzK09GVE1wR0I2?=
 =?utf-8?B?bEc2Um9xQml0SmpuZU5HNEVsQkRNSlRHb2NxOGdyL3VybXF6QWZEVlRsWkUz?=
 =?utf-8?B?WXpUbXVxbWlTMW15eUxlRW5YMVVJc3JHRW5vbGZUSWtGYXh2TkRFc3RYa0d0?=
 =?utf-8?B?THhBRUFEcW43RkU0cmtLV3p5T0FaS2JTd0w3SXY1UVBkblc5alVqcFNJYTBE?=
 =?utf-8?B?ZVhKL1cvM0pjSm9NdHRHTnZOa0ZraUcyZUoyaHVQM3U5M2pTT21HeS9YU0Jj?=
 =?utf-8?B?ZjRaRksrTVZ6N2JBYUVBYUhkMERpdWs4Q0hOY0hoSnZ1bnBiYURmRE5jOXdP?=
 =?utf-8?B?U2pqVElDWlQySG9BSVgyTDIrVUVCMHBDdHhFRnRlQ2N4UiswU2lRTkRWNjVY?=
 =?utf-8?B?R1JDT1JaMUtNYmJ2Z0s3NVg1NmFkZVhDYUZMR2hocDJpemQ2d1p1UlVxOVdT?=
 =?utf-8?B?bU1XOTRZb2tnbmdQa2phZ3krSG9SZzdaa1FQcUo1d3hOT0VDeVZsNXZEaktm?=
 =?utf-8?B?TXB4ZWQveEFvdy82TENNVmRwUm9WVE8vdXp1c1dzZS9PUTBUQnc3dkFueEpj?=
 =?utf-8?B?YmpHZ2tnMnBQMW9OMGxnWXQ2MU9PNDhFSkEvQUlFc2hhNEJRNTc5eUpyV0g1?=
 =?utf-8?B?SkJhS1J4SWkwd0xuU1JNYXhEMDlaMC9qR3NDbE9rdlB6bi9SL2lJQ2VXS05Y?=
 =?utf-8?B?S1M2aFplQmhqUTBlM2tCckhETkdkZVhUYUFMQlBTa0RObitHdUJpTmFWeENC?=
 =?utf-8?B?WHdJcFFlVTZzSDNWUEhxZFhpcXhMOVp1WDBtR28wbzhFaktUYjcvSzBOUzM0?=
 =?utf-8?B?bzlZMHhGTUVQUmhaRFRDcytXWXlWQkluR3NwTnZYU1dNQVpGRUdiSFFpWFp2?=
 =?utf-8?B?ekhDd0F1TSs0azNNQnQrWnNrby9RT3V5Z0RNNmVZQzgyU2FvdDVScjQwOUJ2?=
 =?utf-8?B?V3FxMHpnOVEvNWZMMkhNRjk5b21rdjRnUVNBSlpFMGIvSlhhYnRsdWh1SFNX?=
 =?utf-8?B?VnBlZmlVU2lVb1JLeXdUbzgwTENCcFIvdDE4WiswRjNLZXJkZEZXT0Vsc05V?=
 =?utf-8?B?bWV4OFJ0eTNpU1hzcXErajcrdDQrczczdHYwMVdhdkhtcGl2c2lLaTlxTTFO?=
 =?utf-8?B?VSt6NWlhaWVnZzlqN0dlQUtJSlNiOThlSnJsNzNvdWhzQlREdEhVbEZFVnU2?=
 =?utf-8?B?Tyt5NlFqSWhmTlZwdmVwWWUyTnpqN2hiUmV3MXNPWUVyU05RRTZhbUQycDRr?=
 =?utf-8?B?RjBWWSthZ2hRQUVFdVV0dlRub0tXWkRWMHMxa1NaSHJKUzFzUTJDNHBYOWVt?=
 =?utf-8?B?RzBZYWJnWHNJa0JJc1VJbWVrREpXSDdrbzF0WWI2cVNiRHo2VmZYM3ByMXQ3?=
 =?utf-8?B?SW15RENOYWxTSWMxZ0M0ZFBkcU1WclNwTlhWMGRMVlVHNjNhc0RuSXRZajJ6?=
 =?utf-8?B?NHMrVzJiQk1lV1VLWUM3NHRVZGtBZjVnazdsd2Uxb2JkZ0xmNld4d2VoODJ6?=
 =?utf-8?B?Z0VGSFk1NWliV3cxTmxUQW9yQS9JaXJEcFBvWDdjckFkdmNZMTdjdG9vaWpW?=
 =?utf-8?B?QlpuQ3MwdTBUWGNlUHBBcnVyaGNTSU8rbzJvNFEvTkt1TThOd2I4UExrWmZj?=
 =?utf-8?B?M3FEUkxlV0tRbnpqajlva2dUcWxqQXZZZEFtTDlOQWpqNWt2ak9RWStxZm1t?=
 =?utf-8?Q?3BCA7zbBkeqZFP57BO5RAsFzCpyxV53amfB6zUtU1c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB16D19FF80A074A9CC7556E9A288C37@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WUxtZmZIYXljbWpwTUdxL3dHc3lHNithdisxckhWZFp6SklnWlVkRnBvVmx2?=
 =?utf-8?B?cXVvVFpDM0NZS3lURUU4eVBLY2dabUdQS3hYZHVvYi9aQWJETzdVWGl4RDlL?=
 =?utf-8?B?WVg1M0hISWFydnVPS1NlTmhMK1JGQ090UjYrM28wZFNDbHhjNWVDTmJEWk5V?=
 =?utf-8?B?bmJwZVcrdjRvYUV6SStHTE5HNGFwTS9jM3Y2amV3V3B3VE9HbVdIQ0xydy92?=
 =?utf-8?B?SGxFMklDNUJJbXdOakRaNkI1NVlaUngrUEtoTWZNMmNKRHh3YWxxWCtzaTQw?=
 =?utf-8?B?UEkwMDB2OEV1U25pdVhUZ05iNDZaUlpxTGE4aEJPN3VMQVU3MEtGaXVKLzRa?=
 =?utf-8?B?TmdmeWpONXVZeHQzU002cnFHMHdRaEM4Z0diUDgzRVJ2WktTQUVRVUpjQVFo?=
 =?utf-8?B?VWtvYytjVzFybDlKaXhKZmJodi9YSEkzWElMaTBJQjZPQTNuWmVSSHgrak1L?=
 =?utf-8?B?UGZHaCtGZmkralZmSDNadlo1V2NFVHJJV2pnY2VQaEp3d2hmTjNkZitrckww?=
 =?utf-8?B?NGxYSFg0dTJxb1ZnNFBwbDlsL0t3REFTc25iTUw4OFlSTmpYNjUzNjBwN2pR?=
 =?utf-8?B?RTRCblVHb1N2MTVLQlFlaFIyOWl1WGhoL2VjVzNraWczN1BneHdGMEVDc1Rm?=
 =?utf-8?B?K1h6c2JBZlRENitKZHJKalZVZWRsKzBtbGpodzhJQUVaSVdTK1NmelE1cG1q?=
 =?utf-8?B?VDIrbWdkMmxZaXczMEhTa3dEMGtzRjlOcHA4TngrR3duU3V5ZTVBaksvc0E5?=
 =?utf-8?B?eFFPbkc2VEJaMTBPQ1FkOXVaSWJJc0JhV2dOUmJISmw1ZS85RVNza3VIeXdJ?=
 =?utf-8?B?UmpQQUNiaVcyTWMvcVhQQ0RUMStjMllTdjhGZlE3TTNVZ2ZwZFdpK1dTZXVE?=
 =?utf-8?B?c1lMUFZmYlcyV0o5bVF2K0Y3YlVJTnBkam5pTXhyZWxrcXNPUTBjN3UxZU5W?=
 =?utf-8?B?YXFMeFZVMWR6VHRBR0ZQUGd1Z2c2TDZEbERDNzBic1h2NFRrdEs0ZHJiQnpV?=
 =?utf-8?B?b1ZQaDg2WGd6Rk15SFZvMEdrNUJWQ1VmWDRMR2NtTkVCaktUMGxFOVdLYXU3?=
 =?utf-8?B?OFN4a09TMHdGcjFCaVRwTll5S1dTQlRnSGdtM1ZRSFFLRGxLeUVzQnI4N2Rm?=
 =?utf-8?B?NjhGeFBPK2lJWkR2TW5Lc2RMWjNtVXc0VXQwdFpnc0dqUDlpbHQ0SUJTZmp3?=
 =?utf-8?B?dDVHT3B6NzZPMnUrRUU4cnRrQ251UnFQOGdiVGt0U2xEMllMb0U1QWdNRWg4?=
 =?utf-8?B?SnpWVHZyZlc1UlZNQ0poNFNDWXF3aVFHSTBVY2ViZXBJSWxtdHpoU2RWY3JO?=
 =?utf-8?B?UTFHcDB0SUduZWlzeGVhcXRwbTdJRGRKdnBxOXlBK2RFYzNxU3NYTi92SFl2?=
 =?utf-8?Q?iB607+1hzjanms0U4n2NoxHcstRKlVGU=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648bf7b0-e6a7-4525-4dfc-08dad77ce384
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 11:27:41.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iv+CO2g1NXgZk7OCPPPpfxFAl7d4A7r1Mkv985X23KG0IQnSNE0ba4i7b6QVo4YQC/FTJaBsRPaLaGUHkh9LEOLAA7il8Ze8W1SMATbM9zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7979
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
