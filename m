Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D143ED44A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 14:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhHPMtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 08:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhHPMtV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:49:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8911C061764;
        Mon, 16 Aug 2021 05:48:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d16so8864230ljq.4;
        Mon, 16 Aug 2021 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IAseUJzCEH3EGqR891+PdvwcBt5uEgyLMqq+opj8S3M=;
        b=CWHqECygy9DQCAIDNbOx5cSJT7oXu06wN1f6J4ZzT3BxRAOmR+JDHcEohf/xjXMDEZ
         tr++ZkV/+vnNEs4frOREIBmWE7GCvZPInjym1EClTRJddOiVWTDxv1r3p9sopMwPMBpk
         ny6Ydi28Cw34Uqkc6Njg0IbTl1N3a5bNYjKVhYAIZkjsh0WvgMQFBY/9IEBBk/2Ql4h3
         /fjGwz8QZSXLlsVhL7q63/G3JHbkG4rZXll7h+NjA025Ru2rhFlO2NwU+WNUw7AS9okm
         XZTXcvOkmxx1M77iJLlKwbmHerLS+Pkv+kyZK3sEvoZANVY+Z5iC95J6PQejwqSV+rCO
         9wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IAseUJzCEH3EGqR891+PdvwcBt5uEgyLMqq+opj8S3M=;
        b=iwUZoyPYNv9V0wEDxba1oczls6vBfdryS6Oouiuyn6WN4E+WAp1EQPnTXWrhdZmWx/
         zS0wIjNKD+qZsy5jJTZi0wEQHzyr4hDbf5eXuwITqHcpgnTGBPmDVoxEVUaKir9usryU
         HKQjQ/cYpq/MJTJb4cElHaFR8oEaaf9+7VvpZbeu2K8ZbAvJbaRIsoFSgHkz/Zk+U9Pm
         DI4ufi1DwaxjTqK8D1BqwvhLBd9VpGCL7B2LXER4YDgSdtRomQlpmfWmY68k57XE84XN
         HGK9cQisYrvTZ1jYKY8CzSzb6CqC0IriziHYMUDuRXEvSljDqce373ayGY98o8yFDT85
         hyKg==
X-Gm-Message-State: AOAM530uyhIxy9HySr6prwxv/tU798jFCGl+MQs7ZpJo8wzYhBgbFdKQ
        5opcxsKeWXVvuk6Y2v/jOsY=
X-Google-Smtp-Source: ABdhPJyokRtXOdYbc9fYHAFaKAkBRDUCseGttle5YbiP+rZH54yqMi8rEAeCFs1cVaLKFF3KsiIi1A==
X-Received: by 2002:a2e:a811:: with SMTP id l17mr11921981ljq.456.1629118128250;
        Mon, 16 Aug 2021 05:48:48 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id h1sm940645lfv.226.2021.08.16.05.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:48:47 -0700 (PDT)
Date:   Mon, 16 Aug 2021 15:48:46 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/4] fs/ntfs3: Use new mount api and change some opts
Message-ID: <20210816124846.sp4topnxfyamc62y@kari-VirtualBox>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
 <20210816122721.GA17355@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816122721.GA17355@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 02:27:21PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 16, 2021 at 05:46:59AM +0300, Kari Argillander wrote:
> > I would like really like to get fsparam_flag_no also for no_acs_rules
> > but then we have to make new name for it. Other possibility is to
> > modify mount api so it mount option can be no/no_. I think that would
> > maybe be good change. 
> 
> I don't think adding another no_ alias is a good idea.  I'd suggest
> to just rename the existing flag before the ntfs3 driver ever hits
> mainline.

Konstantin can suggest what should we call this.

