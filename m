Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6E74099D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhIMQr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbhIMQr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:47:28 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3672CC061574;
        Mon, 13 Sep 2021 09:46:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q22so9437698pfu.0;
        Mon, 13 Sep 2021 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=conXI1S71dzOKN/GsCD3g+iOZCipj3z63WFVKKhrZag=;
        b=CuVJd2NjLKuXwb15yGRvvjY3Gw9r+S46a2UWofPxgvZWhvKyou3neHa6HxpVJC9YF6
         rn4Vw9c6zK9TVRh9UV/9XPFXFQvdqcYQsB/vAjkeYGoN8NWtY0lsmMk6eMYATgPjktJf
         K2L/ZPRuTNfUrHK11lLkDd7Y84EKVUXDTL66NYoM1aSly6vjulAF9QccBhuEr9H+rvBE
         5VxuAI3BYeLwP8JHmD5t0fZhNw1MImFtV6evDlp0ucmi0XPFTfbEcAZ9+/liP0StvQOz
         sKCRKg4PStV5PJ1jIjcRIjGgr7s+jRus2RuuzN94yEuaYtN1tUkoLX57A+npTgaBugox
         tTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=conXI1S71dzOKN/GsCD3g+iOZCipj3z63WFVKKhrZag=;
        b=0f1Nm/BSPR10pLCWU5lMpTaj0ZGVUPeOPD2c+f8poEBnqhjIqqstBWMEg+mh0F7n28
         PgMskEmXFaHXb2qKRq/4dauYwe/J0HzWq1o1YdQ4fcB4dWijGtfSJU+BhEaNuD++uryE
         rDFX4Negb9wXqLlpPPiPfIUBHt6L9uML1juAW87RahNinmUMXFotvusfGZ01yt1Wbisl
         JVSWKycdIz7ElYiJpQFDyw8sjuV+1TdqIMb914U9gRbpgv2e8rNX/x8X2Tin+TMMiBL5
         5yGEkiTWEvQe1QBGb3OmKMqF1UkxnOH+HZcdmlIr1mlWxARvQRWchGaAFO03DOCXJI1K
         iHjw==
X-Gm-Message-State: AOAM530LSwkmn+VZLqqc97d8cqt6iFuA0br7VL4NbEkL2TM2TdLCnlnk
        QLaDQxWvCpMFgl6YTc59b0U=
X-Google-Smtp-Source: ABdhPJxHdQMvwexSH17nMUUBTJHUwd2zo68lbHBbS+Iya/3YAr0yqSwuXcAu/E6pjL0PV2J3eTs98w==
X-Received: by 2002:a05:6a00:2129:b0:434:ab92:5af4 with SMTP id n9-20020a056a00212900b00434ab925af4mr427576pfj.3.1631551571479;
        Mon, 13 Sep 2021 09:46:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g3sm9250617pgf.1.2021.09.13.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:46:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 06:46:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: start switching sysfs attributes to expose the seq_file
Message-ID: <YT+AUXZPFWRSFCRK@slm.duckdns.org>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:08AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> Al pointed out multiple times that seq_get_buf is highly dangerous as
> it opens up the tight seq_file abstractions to buffer overflows.  The
> last such caller now is sysfs.
> 
> This series allows attributes to implement a seq_show method and switch
> the block and XFS code as users that I'm most familiar with to use
> seq_files directly after a few preparatory cleanups.  With this series
> "leaf" users of sysfs_ops can be converted one at at a time, after that
> we can move the seq_get_buf into the multiplexers (e.g. kobj, device,
> class attributes) and remove the show method in sysfs_ops and repeat the
> process until all attributes are converted.  This will probably take a
> fair amount of time.

The whole series looks good to me. With Greg's sysfs_emit argument aside on
which I don't have any opinion,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
