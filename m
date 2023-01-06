Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A712966096A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 23:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjAFWTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 17:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjAFWTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 17:19:13 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66A8061A
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 14:19:12 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d127so2217263oif.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 14:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVxeFhMs656qToIBvgcEsQr1rwjSd6iNz/BK1n8yRNc=;
        b=CpQ3Gk08dwid0GVATgRVt2z7pc8FnImqLR9kKrZHmiY/Ok0IApIpwYsm5VcFraeLk5
         rpGyhyFCNZyd3elmTQsLigiMggV7vnL5RnO8OlCZd48ReYnLamtzlWAVGrdkZwiHQYAd
         iDtGXAvQ2VXI2lOX1DzXNd0oQvQzKUwnEa9XHP2s14p6R/pzzhih+vpkBGwD7JbUQd00
         M5cneslyVRI/HYbAge0FIquxFq9AliI/BrInPKXDopBYN8lUldtNWDZft3otfV5gY9V/
         endwGhgUX/7OgUndotgYI4lqdQe5GotY/+m0OETjXjuS1N6dxkA691JeTm7G3FJuyMe3
         D4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVxeFhMs656qToIBvgcEsQr1rwjSd6iNz/BK1n8yRNc=;
        b=AbZife/pX1JXXMZ0TfcuAfYfvchxxavfyKDoJI4igY12+JH8r8zHSdA4/K910PDcaU
         8oe8AfyEeOEmsPONnLWDzGxmFg99TYDmUHW03CIdvhtAYgcWFaWlSiHrv5EHOgvwDmst
         iY00RfB/li80px3brzzn146VqIdVDR7JLlZpL23ePU+bPqRMMwAyPVr6T2YqPa1Oe7+P
         wEl4HxtWoP20lizkRChRo1JTqOsHsAX3riT6KfZkHcQ8LkopjcRLeU/xsTzUDEM0Zo7Q
         cQr+hXBbv4nXyzqNmiVRrF9fyYstG+0CUyEUIFN6xK79l86tL+s2n/je28fAEbIojLjN
         /8kA==
X-Gm-Message-State: AFqh2koMotxOqw1YY6ZlY5JmQXGw5+kPrZxgWwb9dwwDDC+up/9OKGTn
        JHS85TBSWkQuqIH9H3qiH9iXLg==
X-Google-Smtp-Source: AMrXdXuYmumv23wJ+aL5YLlXETpsmLuFM1b7SvxsbCI5SdEG1P79tyS1vfgCozB0LVhB3TFu6Apr1A==
X-Received: by 2002:aca:36d4:0:b0:35e:ab65:e4ce with SMTP id d203-20020aca36d4000000b0035eab65e4cemr22904479oia.26.1673043551694;
        Fri, 06 Jan 2023 14:19:11 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808008400b0035028730c90sm904914oic.1.2023.01.06.14.19.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 14:19:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
Date:   Fri, 6 Jan 2023 14:18:59 -0800
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E27F7A9-5E5D-4995-B612-698B126C9975@bytedance.com>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CC: LSF/MM/BPF mailing list. Sorry, missed the list.

> On Jan 6, 2023, at 11:17 AM, Viacheslav Dubeyko <slava@dubeyko.com> =
wrote:
>=20
> Hello,
>=20
> I would like to suggest to have ZNS related session again. I think we =
have a lot of to discuss.
> As far as I can see, I have two topics for discussion. And I believe =
there are multiple other
> topics too.
>=20
> How everybody feels to have a room for ZNS related discussion?
>=20
> Thanks,
> Slava.


