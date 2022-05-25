Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E3533F0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiEYOZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 10:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiEYOZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 10:25:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A28BF;
        Wed, 25 May 2022 07:25:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g7so5322792lja.3;
        Wed, 25 May 2022 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mavW/LGtnxP01FpE6h9ua1E8SGrgUbvbFScKYyfwT9I=;
        b=SpmhM9zO3tyRxP9X3H2YXWOp+aNFq7mpCNLFjwWLtdzTSnG6KlSpijfc8xwa73AKmM
         /WQKiclvHxETn9GfoLO5+LuMOUi6HyHVehJjbuPJEyf2xnYTj/4DreeVmDSa68PvGHmC
         jFv2NtX5NuzDGVLehUMiQ4o/+aWit1Uqqb7iZlTIAESlPM18IjzyhhI6KB1t9+gqaw+V
         p/tJC8FV9QdEPeGNRPEgWJbhoJgMFTPyLuhwm1fq0vOBEr7HYmmzRbWhR6CZ3SMMv/74
         wxgXZi35COnlggf2ntKeVip00ufMQHv2G0PR7OL7RrYJ55GdKSfNiwVmBvuAsIWmWXEg
         t2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mavW/LGtnxP01FpE6h9ua1E8SGrgUbvbFScKYyfwT9I=;
        b=lTcGFXVzPQsctOQbeVLJLQ7n2hCife0i7nPSauoxji1etAwOcB1YDCwMmYpcqU+7gb
         6RWdvnYta5a20KSBLMU4ryahd6QfC+UOhO+f3e6OEtirGPUpBHDqohCe2gfnOt3ewHMf
         lhThDndPBOKyLP5mfEMy7dVRUyyMjrUR5f8PnkAAtleKjtYdlQoZn5/6fXEpk//5JWVa
         CZvRNIFpOMj1lcqg0K6Rjz7UDiKqjPMlEgfHdz4W2T9Sw6xp/nKyCK03RsiDEWMfaMJU
         lnHPj9SMDovH24J39tB7WITyja/oCRokQs8rhBxo2TC/w0C73kSCMN5BrRE052PE5HKm
         SSvw==
X-Gm-Message-State: AOAM530wY/3Ho5M54DuvuODQa5EJMvPJtd9JsVWWo9H/et6c9yoGVKVR
        H6QGttfaFhDq4Mimj+pjdy0=
X-Google-Smtp-Source: ABdhPJyKM1y/BNj0ssY3RhzGfsiidwrfpMZeIJAfq/8NSduFcQzG12W3E3F+pjeq/oTiP9iqNCEtYg==
X-Received: by 2002:a2e:1617:0:b0:253:d9cd:ed73 with SMTP id w23-20020a2e1617000000b00253d9cded73mr17483798ljd.291.1653488722876;
        Wed, 25 May 2022 07:25:22 -0700 (PDT)
Received: from localhost (87-49-45-243-mobile.dk.customer.tdc.net. [87.49.45.243])
        by smtp.gmail.com with ESMTPSA id h29-20020a0565123c9d00b00478931a619csm889661lfv.60.2022.05.25.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:25:22 -0700 (PDT)
Date:   Wed, 25 May 2022 16:25:21 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Message-ID: <20220525142521.comlig5xrtpsw7tb@quentin>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-2-kbusch@fb.com>
 <20220524141754.msmt6s4spm4istsb@quentin>
 <Yoz7+O2CAQTNfvlV@kbusch-mbp.dhcp.thefacebook.com>
 <20220525074941.2biavbbrjdjcnlsd@quentin>
 <Yo4xKSEI9Kh93gtf@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo4xKSEI9Kh93gtf@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 07:37:45AM -0600, Keith Busch wrote:
> On Wed, May 25, 2022 at 09:49:41AM +0200, Pankaj Raghav wrote:
> > On Tue, May 24, 2022 at 09:38:32AM -0600, Keith Busch wrote:
> > > On Tue, May 24, 2022 at 04:17:54PM +0200, Pankaj Raghav wrote:
> > > > On Mon, May 23, 2022 at 02:01:14PM -0700, Keith Busch wrote:
> > > > > -	if (WARN_ON_ONCE(!max_append_sectors))
> > > > > -		return 0;
> > > > I don't see this check in the append path. Should it be added in
> > > > bio_iov_add_zone_append_page() function?
> > > 
> > > I'm not sure this check makes a lot of sense. If it just returns 0 here, then
> > > won't that get bio_iov_iter_get_pages() stuck in an infinite loop? The bio
> > > isn't filling, the iov isn't advancing, and 0 indicates keep-going.
> > Yeah but if max_append_sectors is zero, then bio_add_hw_page() also
> > returns 0 as follows:
> > ....
> > 	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
> > 		return 0;
> > ....
> > With WARN_ON_ONCE, we at least get a warning message if it gets stuck in an
> > infinite loop because of max_append_sectors being zero right?
> 
> The return for this function is the added length, not an indicator of success.
> And we already handle '0' as an error from bio_iov_add_zone_append_page():
> 
> 	if (bio_add_hw_page(q, bio, page, len, offset,
> 			queue_max_zone_append_sectors(q), &same_page) != len)
Ah. I didn't see the `!=len` part. Sorry for the noise and ignore this
comment.
> 		return -EINVAL;

-- 
Pankaj Raghav
