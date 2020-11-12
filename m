Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D92B0079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 08:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKLHo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 02:44:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14769 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLHo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605167065; x=1636703065;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uabGWrQLJB2iyuUq0aP94ZhvET6x1Cr5Xye3TVrBgKU=;
  b=QZS0ZXXZ7PJBvvDL/RmCEd5gz1sIhvjgL8E0KHTSD6GEs9dbkzq8Ngnu
   cluZMRVbIBPxsfBOyMdPq2KgdoXsTgLRaHF5dkiCptQ9UR0ZDtNcWeFnS
   tgaDdwp0kmeJudoD3gUTKu17nYh/M8xUVTBe3IvG2UnKwqaAgFyL+xX1g
   +qqNpmdFtdODMyX9edv/eHbSflqoNK4jThV9aarvqcHgccd1TP17uzd0c
   07rG2rfegXYBnXTL5x11UOgZgd2yyWdtVS+70APq9J1uNxr/esivIBQdv
   jBrAo0+6fInBnlctGMA2l3ojY65NsBNeDrHgmY8jAwAEA8c7WW9z/WZTr
   A==;
IronPort-SDR: CH/4y2r2JWuwBWAFpk6IBcJez8Wzq5TcJPU2DAAsvkxR1T9INLZlJljFpzE91Rj045SuAxIXiL
 hFqTbWGNFrA86cOLR8wIegb+CdRIAfVvAAr5CeAN3GmvNe3Tef9IRTInMGRU/SfHqiLIYOJnfc
 gio2q2odOkHcQYb8wPhNw+rmzxF9sZMPELfmCpsa/Dgw5ktHrbVuXSyFEK0UIi/wHRJZjMK1cp
 6QSA1jBSkQNYR8HRxHBUjbCBAycVJuTr6j/A/qBPNytwrsJZwQlY53n4pv1UqKZZOu4cC+4jRX
 Hxs=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="152558411"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 15:44:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wg9T1ZcJTjq42I7ELfaIDpjcjYE2Kbk4Z3GR44Y0Z33CYCVDiKiGeLwwgJMvkuqB7UEeCzhpxcC+7+3+Raedtvg+g+SsriO6MyhEtvKggxHs1yl182clnTddI+upl9GtLKKN9h0smZadmbVf0ocWGRi6EeCKPKVpmk1CMb/wzYVJdahL957YIKj+drMsUEaNOZ5dvZU8mpCxJ3udfqlFAfqyCo1s6KMuKlPElO/8+XvOKz6VA5m0C161scKFS84rh1AZKkF0Cq+eBD7YRh99WATm9zUjGA7qlbIPnrERkI9aeyD4uSOSh2UgFKpFj11R8ujHR+vKLm4a034D+qBRNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUKwQTS+1hx5eC6A12bdS1MUW10BqVTlFpnkJ59Xm6E=;
 b=FPtvYgq8l4qrgkunskZinpuO6XaGNv2IcO0TDvbceNXTst4XeBu6R2o0Yn8BwtzTqGwrF6UrquVY0jEF/b4b0YsWJhiV1W3Loe9M5M9Apf+7w15coBba0/5JV6WzX4sMbzUXxTVQEPzLYp6kEC8uk59wWZCde6ISVQXdB0YPzmTCVyoV/y6AWaYNTBxsCYRB8TuTaRp+jcidbyarhWJ+6+DhKgC4GFFI3Mb6J2E4ZZCKNMEacM36y8DmUOR59SVj3EEJC7hXyoX2NKqzON/d8NwkEajqwv3Fz+t7GdvTuod3yjOcuTvEKAkmq9gRwf9BBIblmwvNonhKwU9WOW3iyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUKwQTS+1hx5eC6A12bdS1MUW10BqVTlFpnkJ59Xm6E=;
 b=CqBtq0cr18x9tkWQH409oX8QRrXVxIE4R9Wyrn7ciGScUmEvWyQFQGqLGzqSvEYw0Psnl/b2WFeMFizd3Fl0HdbvfsTyaiJ+U73/QRreNT0jhXAGgh11ZSDa1/nMh7ANFHEh/Cq1eG4ak6Yr/GzGs7DbsZVAk1zKZIJThQRQmGE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4530.namprd04.prod.outlook.com (2603:10b6:208:4d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 12 Nov
 2020 07:44:21 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 07:44:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Topic: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Thread-Index: AQHWt1SWvHhLjwaA+E2FRhr9fhkwUQ==
Date:   Thu, 12 Nov 2020 07:44:21 +0000
Message-ID: <BL0PR04MB6514AAB6133006372B04711DE7E70@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
 <SN4PR0401MB35981D84D03C4D54A3EF627F9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1511:21c9:a204:82eb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b34d3392-c469-402c-81d5-08d886dec494
x-ms-traffictypediagnostic: BL0PR04MB4530:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB453010513A535A8404EB1193E7E70@BL0PR04MB4530.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n4+G4aynxJ8FQxYhbTXW2rWhqt53bWJweAFLp3638qbRT7wb0MWRhjNH6UhmTr6KourW6WHSHMA3pq6Nc53YxDdUAwSfAsm7YrdsYkEGMnDWcxEAIBlRxUq2c3hW6aq8h75XShKS4BiSj+mAKJ0r2/PHmLJEXjYcWEjpfESy7eyjcuH82u3RioJrAW+Liow6MRTSnzj7azzLYtd9WemNQXZVjBEM2Eu5vLUwM6IH6pB2ri+DMqC6+knMoWtQ1QjBVrYwAkE1VvJcbTOMD7fTRppSYCamgljJeukvlTYL8cCSNFSfA4Gtfo6gHK6oUCYbBiV2auBkBU6tjD9JthPjNPNd3TUeT1hxIhnZbkIypy44b8m29BFsztH1/ICmBqDLv9NjRSgjMHeYj+jFhhNMzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(2906002)(64756008)(5660300002)(66446008)(4326008)(54906003)(52536014)(71200400001)(83380400001)(9686003)(86362001)(33656002)(478600001)(966005)(53546011)(55016002)(91956017)(66946007)(66556008)(8936002)(316002)(186003)(6506007)(7696005)(66476007)(76116006)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: c9bT2hTZWBXbdWqYwb8IeUZ4l06ShcH+e0+ZzZ0XCil6snMHnoFivwRSlQJcFyzwalyExLTuUuO1H8pxPdSoU7pNfkpc8wcDEqsnlytdnYthXEeSnCHQAj2fvKt20ltQ1dLnhU9AJxTiRd3X4AACcCIKzetg3eapSJ9GjjpJRe7TpTJf+W1UKHxMi/95boMH3XCf+PHb+e2/6ZcaRkxZmdmiJX7mC84jJ08F44tt0CLwTrMkMa6HlfkIKgqJyZUMSKCR4RAn8G0ARQPDHl4KsM5IEA4s78u9hI5TgpTe4PLUWVmFiqSbrMJ4oGWI+tvrivOf9PoQ1XInWr5f1EhxEHjLJwVno9YEEotWigSq61f4FpTzg1DhGPZ3XbMFCbMCtrqgbLbgLTUL55hSvtw2UTMUlrxv2Aef1X1FdngzISxa7/yyNYOapZqfJbEUcRdxZ2TCmIlYCMpXjkay8C++kQtxcf6m9qELah24P0GE1YEKKW2NW8OgbS88vOQQOOLzg/jPlZRwEDj8El6GQKNrZk/SIdAQRylRJdf+iQW4Wgq15ZZDf3P4jQFGeMtNV8K8qktmjfv7AS37qhLGRCBKPdOvBuD9ITcyF7eez8kY/EwdmNjYOjCoxifRW3s62A3OKI+sSSDsrVkJdW7IfFJXzV4aYAq281va651koZg0USvbKZsr9xNYufj3UVJEhbpu0UAMm/4wgvYyRppOw7Rjng==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34d3392-c469-402c-81d5-08d886dec494
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 07:44:21.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZdZ1AWbWMRXF4EC7ziW1wR6K6/Is3K5LtnxnWxSVoZIhcn3Rw1O9uVz4dSaILJItvtG85QDpQXjyASdWXQljQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4530
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/11/12 16:35, Johannes Thumshirn wrote:=0A=
> On 12/11/2020 08:00, Anand Jain wrote:=0A=
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
>>> index 8840a4fa81eb..ed55014fd1bd 100644=0A=
>>> --- a/fs/btrfs/super.c=0A=
>>> +++ b/fs/btrfs/super.c=0A=
>>> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)=0A=
>>>   #endif=0A=
>>>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY=0A=
>>>   			", ref-verify=3Don"=0A=
>>> +#endif=0A=
>>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>> +			", zoned=3Dyes"=0A=
>>> +#else=0A=
>>> +			", zoned=3Dno"=0A=
>>>   #endif=0A=
>> IMO, we don't need this, as most of the generic kernel will be compiled=
=0A=
>> with the CONFIG_BLK_DEV_ZONED defined.=0A=
>> For review purpose we may want to know if the mounted device=0A=
>> is a zoned device. So log of zone device and its type may be useful=0A=
>> when we have verified the zoned devices in the open_ctree().=0A=
>>=0A=
> =0A=
> David explicitly asked for this in [1] so we included it.=0A=
> =0A=
> [1] https://lore.kernel.org/linux-btrfs/20201013155301.GE6756@twin.jikos.=
cz=0A=
> =0A=
=0A=
And as of now, not all generic kernels are compiled with CONFIG_BLK_DEV_ZON=
ED.=0A=
E.g. RHEL and CentOS. That may change in the future, but it should not be=
=0A=
assumed that CONFIG_BLK_DEV_ZONED is always enabled.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
