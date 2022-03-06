Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014264CEED5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 00:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbiCFXzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 18:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiCFXzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 18:55:07 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E1C4B1D7
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 15:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646610854; x=1678146854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WhA/830efebcsNBeP2i9bOhds10k9f1yyNnKRMTpCGY=;
  b=WkT66iGwBCdPKdNr9I2GCTezACjDwUWKBS/v4pGLIn3az83JH3HYoQZh
   1ZAXs4jmpYTiJw2XzGJ55kzE5OxvCyUo5W1svtcRwxXvKmakx3ksLb/XR
   4uiKBz6HSl0VyeAKTZysONIkvw5wWukVEqtpev7QHHWZLq077f9xKzJ3C
   mcYC0YBGoNFhl+U5HpVFlNa9GuxiFLm7je5z0BNh8FQL3b8F6ZrMyT3Ws
   RZrU6Mf7iIPBV391flHATLVdAvt52hJFvwIeg0UOq7eERE3mT8MHxnkme
   vWxQ/J7vn3853ivBzTX4Eo7p8h/kPx7z0DN+SSsSxJ8f58g15C8QtejQV
   A==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="298748738"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 07:54:12 +0800
IronPort-SDR: GWofgdgRoPFgk3RvWVv77hf7F2Z2FesRpEGagM/e/TNuWUIEVTvURkAlawQPxU9ymmW90EoqhK
 VWw+9KkZFFPSYuboEEZZPKLAbCMGA9jdSOwOCCgJrlL9UNC91ZDmuLjclgrzzdILY01py/Bk6h
 cBL7wbYpWxpHXQxX08MAFRCX9vuUuP5iBo1Svidm8kVQW8n86TAnglWb+nNXTA3klbplDwuVL1
 f06Et5khaMSQxTT7LcKVDt5VTtrYnZTZGyGHG/XEy1uPZR26MdIYl3uGjFa7mvlh0C2iUXlOZn
 InpJa32lfVKyf5os+805opU4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:26:31 -0800
IronPort-SDR: dENTdzdQCjOVy37uC/Lu2dzFyqq2TCT6ucKls3Ikfy2XIbNvOL2CnrXGtzKxNYEIBtogRZJRt8
 yx/aLLA9M+6hBABmtucSk7n3BBtOeKPpeEzlQGhBseztOXxi90t+4BN6wzLFP1iI1dKJ3HWWYO
 8Va5FJilgWWqWsgEUIGeUYOrpI22o8aIJ9xSY4C6TTpB2uEI7dVhcL9cMsrnZYN/4Je9GJwkXu
 WHUt16fXOwC9740bIFCdITqav+eZTH1WdG8NUCtp7RnuIQoiaVf1DgDMd1RmNvPMqsxNXlIHTH
 Njs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:54:13 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBdjH6VFlz1SVp6
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 15:54:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646610850; x=1649202851; bh=WhA/830efebcsNBeP2i9bOhds10k9f1yyNn
        KRMTpCGY=; b=l74GyPy8Vr43+XfhtdT7cxs/77zBKLhfqYTMrEoy+xCMmuFroDt
        XuUC1kzyqsfRZT0mVMGtMdQpbeWFsktYqJjuIh/t24QD1LeJJPI3MVRkFLnuis00
        IPQ5v0x+vqi57KOn/4t/p87/lk1vBf/ZNT1ubKTAg0ATIHXVVV/qsxfyXbA/2Xye
        zKhsmp1Yb/P9EyC5EaQOTs1K0L1DwKfNcgqAfYoMcipjNWvbwEQ20ykvolZ3naZ4
        pakjnJvUnGtFgicoLEpT6xBpjpr5jaI1zD2jXKT6jm41cmgf0PUdQN7htdMctCxC
        8ogw1i95SzOfizH2iYwHPk+BBlsVGsgtAEA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0dcRGAiWTsnf for <linux-fsdevel@vger.kernel.org>;
        Sun,  6 Mar 2022 15:54:10 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBdjD0Sxxz1Rvlx;
        Sun,  6 Mar 2022 15:54:07 -0800 (PST)
Message-ID: <e7fa785a-c5f1-4654-b771-4a1ef8437082@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 08:54:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
 <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
 <CGME20220303094915uscas1p20491e1e17088cfe8acda899a77dce98b@uscas1p2.samsung.com>
 <8386a6b9-3f06-0963-a132-5562b9c93283@wdc.com>
 <20220303145551.GA7057@bgt-140510-bm01>
 <4526a529-4faa-388a-a873-3dfe92b0279b@wdc.com>
 <20220303171025.GA11082@bgt-140510-bm01>
 <BYAPR04MB4968506D0A8CAB26AC266F8DF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220303201831.GC11082@bgt-140510-bm01>
 <BYAPR04MB49686E8DFFF46555915F65BAF1049@BYAPR04MB4968.namprd04.prod.outlook.com>
 <YiJyt79fELL6+/fF@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YiJyt79fELL6+/fF@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/5/22 05:12, Luis Chamberlain wrote:
> On Thu, Mar 03, 2022 at 09:33:06PM +0000, Matias Bj=C3=B8rling wrote:
>>> -----Original Message-----
>>> From: Adam Manzanares <a.manzanares@samsung.com>
>>> However, an end-user application should not (in my opinion) have to d=
eal
>>> with this. It should use helper functions from a library that provide=
s the
>>> appropriate abstraction to the application, such that the application=
s don't
>>> have to care about either specific zone capacity/size, or multiple re=
sets. This is
>>> similar to how file systems work with file system semantics. For exam=
ple, a file
>>> can span multiple extents on disk, but all an application sees is the=
 file
>>> semantics.
>>>>
>>>
>>> I don't want to go so far as to say what the end user application sho=
uld and
>>> should not do.
>>
>> Consider it as a best practice example. Another typical example is
>> that one should avoid extensive flushes to disk if the application
>> doesn't need persistence for each I/O it issues.=20
>=20
> Although I was sad to see there was no raw access to a block zoned
> storage device, the above makes me kind of happy that this is the case
> today. Why? Because there is an implicit requirement on management of
> data on zone storage devices outside of regular storage SSDs, and if
> its not considered and *very well documented*, in agreement with us
> all, we can end up with folks slightly surprised with these
> requirements.
>=20
> An application today can't directly manage these objects so that's not
> even possible today. And in fact it's not even clear if / how we'll get
> there.

See include/uapi/linux/blkzoned.h. I really do not understand what you
are talking about.

And yes, there is not much in terms of documentation under
Documentation. Patches welcome. We do have documented things here though:

https://zonedstorage.io/docs/linux/zbd-api

>=20
> So in the meantime the only way to access zones directly, if an applica=
tion
> wants anything close as possible to the block layer, the only way is
> through the VFS through zonefs. I can hear people cringing even if you
> are miles away. If we want an improvement upon this, whatever API we co=
me
> up with we *must* clearly embrace and document the requirements /
> responsiblities above.
>=20
> From what I read, the unmapped LBA problem can be observed as a
> non-problem *iff* users are willing to deal with the above. We seem to
> have disagreement on the expection from users.

Again, how can one implement an application doing raw zoned block device
accesses without managing zones correctly is unknown to me. It seems to
me that you are thinking of an application design model that I do not
see/understand. Care to elaborate ?

> Any way, there are two aspects to what Javier was mentioning and I thin=
k
> it is *critial* to separate them:
>=20
>  a) emulation should be possible given the nature of NAND

Emulation need has nothing to do with the media type. Specifications
*never* talk about a specific media type. ZBC/ZAC, similarly to ZNS, do
not mandate any requirement on zone size.

>  b) The PO2 requirement exists, is / should it exist forever?

Not necessarily. But since it is that right now, any change must ensure
that existing user-space does not break nor regress (performance).

>=20
> The discussion around these two throws drew in a third aspect:
>=20
> c) Applications which want to deal with LBAs directly on
> NVMe ZNS drives must be aware of the ZNS design and deal with
> it diretly or indirectly in light of the unmapped LBAs which
> are caused by the differences between zone sizes, zone capacity,
> how objects can span multiple zones, zone resets, etc.

That is not really special to ZNS. ZBC/ZAC SMR HDDs also need that
management since zones can go offline or read-only too (in ZNS too).
That is actually the main reason why applications *must* manage accesses
per zones. Otherwise, correct IO error recovery is impossible.

>=20
> I think a) is easier to swallow and accept provided there is
> no impact on existing users. b) and c) are things which I think
> could be elaborated a bit more at LSFMM through community dialog.
>=20
>   Luis


--=20
Damien Le Moal
Western Digital Research
