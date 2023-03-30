Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A966CF828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjC3ASE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 20:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjC3ASC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:18:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FFBC0;
        Wed, 29 Mar 2023 17:17:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id cm5so5595663pfb.0;
        Wed, 29 Mar 2023 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680135478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFrxtn9d5G2riP70vvdw/yu25SnT/y5gfBPSK+n92IU=;
        b=KYNyyyhqVrYmGqRxxi/SM2DiuO4mCIY7EWWchExvtXdrm1XO5oDXmK5Er2s+mn3Pk9
         FIXNpsZ/Ua3VaC+qLRcNGDw6wPWb33mnRw6m/M+OaV8Qr7zs9AP2V/DrGD6ZUuF2+OUB
         o6Ua7cfXYbLRFXCBVkwJDiUT5QTRRpeH/v/wIbDaCuyXgMAom79byhB+4uNMuEUEU+k4
         BH1NkWsGPTccS19YXMQKMiuXZTxILZIFb8xHIrqz8VjA3PccOBpiH9JmGdZE1DHpVHZ5
         Tn9nyYB5YUxugZgn8IAWqsmKnLtuXTMPowJSCgZlhxdNAsP1q6BF5/rUHHwmLF1RvMxB
         h9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680135478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFrxtn9d5G2riP70vvdw/yu25SnT/y5gfBPSK+n92IU=;
        b=NEV5fkJIFUz2lXQQf+uvLuDpkb3FXrYIbgLUSJyOTAzsl1aR3yPB3Pb1InXrbEUuXW
         jt9T8hrVTUjjzA5KB8eR+5paXntAWXmb3ugeD/F1aH/TAnmf4+HfKu+B/nnmyn9CKJ2H
         zpgWTkpxG4hxtjWZTKXxq8a0JL86XxWSyGeZzxjz3E0qPlcOlbzVH1y8rYrX3Mim8KPM
         lHgQBiiR4r6+v9Ffp0yT3CTwnoC9mRerFkJhifKY8zKiMZOm0FL4jxar0VJD0DeTT9np
         S5upPp79uC/14DNob6g5Yd9wgiEH/AgikQKNfPzbmeLO9s8lY24kzLMry6VGgIITzI3A
         YWnQ==
X-Gm-Message-State: AAQBX9eVKj9z6fwM8sJrkyYPivXDm1ecCbBxBZePaL09k/znexDjc6Kz
        He6AR11zTWMJDcKiovMxAgvMKh3uMU4Yjvd/uBU=
X-Google-Smtp-Source: AKy350aEVPs1e5xvudW7+v0SaWp4yk4rckHRftoj/jiGIVi7YJx59Ax0QojqF2IskeBIF4cBFMwK7DyHsh5zud9IPEs=
X-Received: by 2002:a05:6a00:2e9f:b0:628:1e57:afd7 with SMTP id
 fd31-20020a056a002e9f00b006281e57afd7mr10923270pfb.0.1680135478121; Wed, 29
 Mar 2023 17:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <beea645603eccbb045ad9bb777e05a085b91808a.1680108414.git.johannes.thumshirn@wdc.com>
 <3a0f0c92-63cb-3624-c2fe-049a76d1a64a@opensource.wdc.com>
In-Reply-To: <3a0f0c92-63cb-3624-c2fe-049a76d1a64a@opensource.wdc.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 29 Mar 2023 17:17:46 -0700
Message-ID: <CAHbLzkoRdTTbnfz3RyLQAeNJBOEVNGL2WLgRSE2eQ4nR8sRe2g@mail.gmail.com>
Subject: Re: [PATCH 18/19] dm-crypt: check if adding pages to clone bio fails
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 4:49=E2=80=AFPM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 3/30/23 02:06, Johannes Thumshirn wrote:
> > Check if adding pages to clone bio fails and if bail out.
>
> Nope. The code retries with direct reclaim until it succeeds. Which is ve=
ry
> suspicious...

It is not related to bio_add_page() failure. It is used to avoid a
race condition when two processes are depleting the mempool
simultaneously.

IIUC I don't think page merge may happen for dm-crypt, so is
__bio_add_page() good enough? I'm working on this code too, using
__bio_add_page() would make my patch easier.

>
> >
> > This way we can mark bio_add_pages as __must_check.
> >
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> With the commit message fixed,
>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>
>
> --
> Damien Le Moal
> Western Digital Research
>
>
