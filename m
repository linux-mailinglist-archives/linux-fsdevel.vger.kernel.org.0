Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20061409921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhIMQb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbhIMQbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:31:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF27C061574;
        Mon, 13 Sep 2021 09:30:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t4so598443plo.0;
        Mon, 13 Sep 2021 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LowWi5dvN4D2b1PZMHbxLLuSp6ngzAzEGjXJpKrV1Cg=;
        b=Jzkw2YcA0YcwR4io5vFdvgubU7mV4jYMaTpllce//2jqj3krYFvGR4gO5ehXVTE01E
         i1uXCAE4lodrM5w3hEcBoqYZG+SOvx/jRa+nHw2lDDd3hN+P11E8VDrtzAiCHdtljckx
         r31etlmlMwwb4oHQLNqKffx0vPhYGvXVvEtnuWvZyFqEJyB3GgNwpCFVqXSPnwbKMZoM
         3fjBp4URtkpAjUpBaoKMVuoFqpaCuJIQOrPDiIvbMY3P/Yys4rvrpYQpTlrdhIDUFWou
         9bG4cQnMbaJeNykbCRIJG9Zr2XWCXdxw2hEeOpjdfYjB4EqpwoAPlt/Dwc6YOjSpyEq0
         9VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LowWi5dvN4D2b1PZMHbxLLuSp6ngzAzEGjXJpKrV1Cg=;
        b=adhEaWuDiFw9lEX2bmtpagLLqXk7vlzvm+Icq38XMz+K91uqnJLsHLBD3nn6VoBa6g
         1PLrxr0g0jwV5OXk/tCdPW8AltMiTo5twfmEOwUweunN07YHJi9FIhi/U+9DVeOJVlBd
         SokvH8eV+fCcBqhPYKxTq2r1QtkP1BDDWfAkHt3Qg9Bk3FjkQfMtOEElqOJhVn21qW5t
         bVxK5/qmBUMuvREvE470sDeq22SHE7U6V5hJf05ZbXcihRoFrHamyQC0TifKGtyBMsXw
         N6Xcw1LAGEpYKNP3xpvC9HzDphW5mpo7c8H0LSf59OKZNPgsr3qDxc4TvLOSo5Cqirsc
         toYw==
X-Gm-Message-State: AOAM530HMOT3lEKPQxCovWMLDHzsdtGFlsSNtIt1jYl9Ss5nuY0D2qI1
        Jl/fAmDzFjrxKg+RKvFcUWvJK922ZLY=
X-Google-Smtp-Source: ABdhPJwTOSlOzoO/EQyNR41h4hMmzFU8IBFGGGFRl+f67ISI0CAwJ4OhYcepyfJ/SBJa88wGP4egEw==
X-Received: by 2002:a17:90a:c58b:: with SMTP id l11mr358131pjt.134.1631550638871;
        Mon, 13 Sep 2021 09:30:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id f15sm2872430pfn.186.2021.09.13.09.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:30:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 06:30:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] kernfs: remove the unused lockdep_key field in
 struct kernfs_ops
Message-ID: <YT98rbxE/+jx4IxD@slm.duckdns.org>
References: <20210913054121.616001-1-hch@lst.de>
 <20210913054121.616001-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913054121.616001-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 07:41:11AM +0200, Christoph Hellwig wrote:
> No actually used anywhere.
   ^
   typo

Thanks.

-- 
tejun
