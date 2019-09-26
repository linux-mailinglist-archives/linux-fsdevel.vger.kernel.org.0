Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA73ABF29F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfIZMMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 08:12:55 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:57683 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfIZMMz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:12:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 00343258E;
        Thu, 26 Sep 2019 08:12:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 26 Sep 2019 08:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=a
        SFYn4mdcHhyVRMuX1XLDtJUHFPaOYqUG4DKEpt9FjY=; b=J3J32l8COJM9NFp2Y
        VR5w64MNj94X8uhafx+Kh80emBRn8SniOMr84DsiVnSdrBKRklGHSkvj2q3YBEXM
        9TczgqclFYlLRLNzVJXH93GIO7XNPIC2+TlN8TbMZ6cBtLYqBLM0kh+XZuNAaWjT
        +HlErijIraO+4qxvyKAsFK6U+p0l5x/3/KW6AB3wCzuuOrQo493ROaXhd/nOXn0x
        Liyna2OfQWqaEPSHGtsoBbRpyFxnNDV989lm5wtvJovO9YJo/po7303x5F2TaeqL
        OUWyl6yEtufYXS7YqmVJrBbzw7pkOcmuGqWoHX9YlOO5jVGNNfkPOXKqyjvVtEXB
        8aotQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=aSFYn4mdcHhyVRMuX1XLDtJUHFPaOYqUG4DKEpt9F
        jY=; b=xp3PDJ/JlTgTgO2m5/71Jqj+QAyyOBe7C1Ov65jSMz1XhQIBlS1Y/Hddq
        l75z3UbEICLeLN5QtkEH5yravFwUU+fapicCKk85okOjJT6xPEPCwrTpuyy2Rv2x
        cyAm2BI0z9JxyEdOffTCrAqIWMcbIQD4/6txPCH/8oxUOgaipEAeNfvlHUMa0X5Q
        fvZY2hHtJ67k3dJMc30vFYYzwMT+3mhJ9j2qeweRhHvJKJjlECgujDdYOHGNjcwi
        n/9Uy6I41cElHGL13HVlme5AESCFmbureS+KMG0Wgk9GgGNOjR7wZuUflbZjoypt
        GBetmJUFUG4iMdUZPrPtz2DU3Dcdg==
X-ME-Sender: <xms:RKuMXQBuL4YgVlLYT-ivmauTjUyKTRd3sONUSq0nCAExv2NLbUJNvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrd
    hfmheqnecukfhppedujeeirddukeelrdeikedrudekleenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:RKuMXY_3zzCnHA4EYneRLVzHjz09HY8sLJHFvRgQV86TUXJ525WhGw>
    <xmx:RKuMXRGW2aSXsXimT8TML-2v-AtY3DhGHXKK_RDVKKhLbQM7Hp-v1Q>
    <xmx:RKuMXfI43kHag5jtRq6-LqyvqaebNOAOmYT1fxKdOnJqyIJ-U-6EHg>
    <xmx:RauMXXqW8DwNrPyOAKDVRcsblSY4aftcG-e5GxJwJQFl_4IbUza9Rg>
Received: from [192.168.1.20] (vol21-h02-176-189-68-189.dsl.sta.abo.bbox.fr [176.189.68.189])
        by mail.messagingengine.com (Postfix) with ESMTPA id 551BC80061;
        Thu, 26 Sep 2019 08:12:51 -0400 (EDT)
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
To:     Boaz Harrosh <openosd@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190926020725.19601-1-boazh@netapp.com>
 <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
 <0bb90477-e0b5-650b-d8c0-fb44723691a4@gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
Openpgp: preference=signencrypt
Autocrypt: addr=bernd.schubert@fastmail.fm; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <91c22d2d-15fd-393d-dee2-8e74bdd8833a@fastmail.fm>
Date:   Thu, 26 Sep 2019 14:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0bb90477-e0b5-650b-d8c0-fb44723691a4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Are you interested in comparing zufs with the scalable fuse prototype?
>>  If so, I'll push the code into a public repo with some instructions,
>>
> 
> Yes please do send it. I will give it a good run.
> What fuseFS do you use in usermode?

For the start passthrough should do, modified to skip all data. That is
what I am doing to measure fuse bandwidth. It also shouldn't be too
difficult to add an in-mem tree for dentries and inodes, to be able to
measure without tmpfs overhead.


Bernd
