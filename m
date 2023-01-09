Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59533663556
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 00:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjAIXc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 18:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbjAIXc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:32:27 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBB7E03B
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 15:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673307147; x=1704843147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vA+kJo9mcJSrJYNA7MLo5GyUZM6NH7xAAwytRE5TsWs=;
  b=XRkfIFurtq8PZWjxmFSWqonJOGp91J5Fs26cDAAuGBKj9DEfYzPDOmD/
   w5ODR7ixShYnEkgZu80Ty1wvlKCs3sdPnL9b67HyRD1Louko1LLPOnz4A
   WHqk7GDOaviUhcgmNuwSY5juX00mcMlbtB4NWFI0uAZD3ydNzdhEEvYrf
   7KYyaBKyht6ZDwvpM2nO9KkTqexbynH3G8asJOpR3jC6fbO+dkH8Mo1dM
   MWxlNi2iSaAEWKi/aNW1KKraGtDDI2u+7S+wxz6HC/RZpptBan7NPxDO4
   akCOyji4kMmeRmyAVuTYEwjfx4zSLAIlCz4td0I3vXElcTpAIOpYe3tzQ
   A==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="225442522"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 07:32:25 +0800
IronPort-SDR: DnDxyl8rhegLkxUxoZH4aHhtqYIvXoDcNhPaaSaDpCZDu8ciZqmwJkoa5sgI/oN+TY8AXPx1mE
 wo64a5TmljGwQ2X4wJVyTu+ZP5eEV406Vat/Ri56qaaGD/VSQ7uMuq2Q0vpoI/ZUD0vzR25aqK
 SCeaOqHyeq+1RspxWS0PgCOAVchxiA4nvR146jaKYeGNAhX2pccSsa31MiATHLbdk7zUdA5JT8
 EhwSUTkrBJ3xNnezL30hq0l+6qM/BOvnm5FAvOQjH6EJQwsLH553ZeYaKuc323ZEHID29/XWsH
 w74=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 14:50:16 -0800
IronPort-SDR: Chif7VtjpjV9OP6ljZPiuqkztXRdjMCpXgmyKVXWMsZ2uq0eshLo5t9j1n7tNjmUjC3Iw7VWOH
 nVEKkLzE0egdExZ4Cp7S5vVyOdytNyE425cRMXal9HDvU5clw+RiDXKzvERyGTE3aUEvYBhQFo
 TJstw3oNHwEiTNZ7VIAi8eXwOWcByO8JA6BV0gnqA6DpulaSIlT4lZhlX3Lb5ODDJhMyeAGIrQ
 ZCndEPs/E/yq7cqeWoikL/kzdY5S4vYt2EpjNYXKc2Q+OAiU6I8F2mtwnPK05JnxZ1JV+zz/6g
 9vo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:32:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrVbY39hKz1Rwtm
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 15:32:25 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673307144; x=1675899145; bh=vA+kJo9mcJSrJYNA7MLo5GyUZM6NH7xAAwy
        tRE5TsWs=; b=AejY6Icqa8AwqZc/pZT8fGX2FtL+GL78uZpF+iz3G0SCFA0fMVA
        aX7/16nS5iOqL6flVyBcXCG2V5Kx6NHV0QqR/MBLFlN/cnoYd9yZKVBctmrKNXbu
        YrqeCdZc6NTxHDOJ23VMK8IRJ3hYdfh+yW9g1EQiV1Qk/Ne7PIy7Su1CLLwV3E5M
        9CIz+UK/kUQJkEIcFvnp3Mn5gP0mfU8QxE4S5HVkKfWt5LO/zKyQBklXAikrIIln
        TMQDKLh+bkD9TwoBvLZDNmpKBzBINQFrFkvnqSCHWnyxko0HTN52du1bD/WK2eT3
        IbOpJ6tEi1D6yoLuOE08WR1UKt9HwZR44+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fevSxmdjco76 for <linux-fsdevel@vger.kernel.org>;
        Mon,  9 Jan 2023 15:32:24 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrVbV5NJpz1RvLy;
        Mon,  9 Jan 2023 15:32:22 -0800 (PST)
Message-ID: <81962ced-f62a-7716-49b7-c6735ebc13d3@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 08:32:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Content-Language: en-US
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
 <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
 <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
 <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/10/23 08:20, Viacheslav A.Dubeyko wrote:
> 
> 
>> On Jan 9, 2023, at 3:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>>>> My point here that we could summarize:
>>>> (1) what features already implemented and supported,
>>>> (2) what features are under implementation and what is progress,
>>>> (3) what features need to be implemented yet.
>>>>
>>>> Have we implemented everything already? :)
>>>
>>> Standards are full of features that are not useful in a general purpose
>>> system. So we likely never will implement everything. We never did for
>>> SCSI and ATA and never will either.
>> Indeed, and that's a very important point. Some people read specs and
>> find things that aren't in the Linux driver (any spec, not a specific
>> one), and think they need to be added. No. We only add them if they make
>> sense, both in terms of use cases, but also as long as they can get
>> implemented cleanly. Parts of basically any spec is garbage and don't
>> necessarily fit within the given subsystem either.
>>
>> The above would make me worried about patches coming from anyone with
>> that mindset.
>>
> 
> OK. We already have discussion about garbage in spec. :)
> So, what would we like finally implement and what never makes sense to do?
> Should we identify really important stuff for implementation?

If users need and request something that is not currently supported, we
can discuss implementing it. Until such user-driven request is raised, I
personally do not see any point in discussing anything.

> 
> Thanks,
> Slava.
> 
> 
> 

-- 
Damien Le Moal
Western Digital Research

