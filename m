Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56776D0313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjC3L0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjC3L0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:26:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A65266
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 04:26:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er13so34076090edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112; t=1680175569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbmV1/m0iRIMdszEiLFpPm23pb+GM+oKJhybgX4Y/q0=;
        b=7npEB7Z2mF4pks1IcI6W2x4mTelolPmRdjaXE8hualLkYH55VmpK9v4BgVGFuka1O3
         Wqamvk55RwgaLHKcKD1rfIKU5ngqot31zwFYC+nA+eZRlHTV++HwsiVDN22oCc09yb+8
         +CLeNOP455QI0vk8gnVSe7M4onJY9w0hluBGbca2rTzbLNfhzISqjvVEyl/kJVU7k7xb
         QwhYOa4TmKcZ0SHXVNjziBhYy5cIfyzy9KL99CGZ2ItVZQOvUgHwcPJJkUNgbiSrVvLB
         XLCRqPGN8hsEH+N5ZL6eg9XP4S+IsYVcmlvO2iZh3yNed7dBgOA7rnzeAxjnXsfoszNu
         TZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbmV1/m0iRIMdszEiLFpPm23pb+GM+oKJhybgX4Y/q0=;
        b=nMhVjIoHkrU8EN2h8V9N+b+3Fmm16rv9N2I+PeWVHXU/x+QnaG/db6vbjDagFBNs32
         a6LiZ41wMfz18/VhFII6z2hNAArqjj8Db8HhBGAqpUfe8kETFgD/sNlrPxNp9amIDl9c
         BjGI3QrluWhmFyRPuOrS9y92mYd5effBLFUToghxyQy5KsqjWol0WtUdIcbvM0EByZWM
         p6w+HFNeC2Sptz0qJs3ENYS2Gvw8xPG8hJ4CdwABSRCWsT0fsYyPJA48PPI2ywItpV52
         1aDQ10muID5VEjjXTy2G0At0DwieNB3qGlPev88cgYh9wJ1OPUzaX3fSkONzS+FM3k0M
         mBEg==
X-Gm-Message-State: AAQBX9eda8cjn6CN4P+ea+I9638udy25d2Q5tzI8jbXqgirWgwxhPDzo
        ARYBTodbTWV3KW49V4ZOhRyumvdLEcTMHomr9wRRQMEUv9PMaSOgd2V2vA==
X-Google-Smtp-Source: AKy350bgmLfs1LFLrqhexga8ZEzABdyA+ciyi2w0mH5aVm7e2T7BHhL+Iw1dn+GzK7sctP8HmCzrOsB0IyHLxDr96xM=
X-Received: by 2002:a17:906:bc94:b0:8e6:266c:c75e with SMTP id
 lv20-20020a170906bc9400b008e6266cc75emr12086032ejb.14.1680175568761; Thu, 30
 Mar 2023 04:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230330015423.2170293-1-damien.lemoal@opensource.wdc.com> <74e8bca1-a09d-fe6b-36bf-f9030612601e@wdc.com>
In-Reply-To: <74e8bca1-a09d-fe6b-36bf-f9030612601e@wdc.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Thu, 30 Mar 2023 13:25:58 +0200
Message-ID: <CANr-nt0Fma_tbTxo9SKFFgkEYNW+v4h8aDmGYEqfmeSQES89aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] zonefs: Fix data corruption and error return
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Retested with this series, and it solves the reported issue.

Tested-by: Hans Holmberg <hans.holmberg@wdc.com>

On Thu, Mar 30, 2023 at 10:46=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> Looks good,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
