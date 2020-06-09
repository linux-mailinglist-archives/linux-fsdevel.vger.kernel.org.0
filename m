Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC51F424D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 19:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgFIRaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 13:30:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37300 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgFIRaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:30:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id d10so10608176pgn.4;
        Tue, 09 Jun 2020 10:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8DHGMTd1sHPkNgYIyz/0Ui2MJBr+K+YUNJeV5ms+EI=;
        b=igOUtULtAknXZjK+aFhId66cBEhCE3CGvTmixBp0iMPwrCGonD99peN8q+oBuwoWw7
         PH3d5WAefviBxWL29Q6m03OQaTHStcig1EUG/ytKg1+pp7hDKycMjZNaYopqiTSnEcSL
         O790CcktcvXwW9fIur2Ds4jXiM74KQKn06dV4uEur6QHGO3SxOljB0tAv3f8Ijl74XN7
         MqXYbYlSR1GIuTmVq/4rL3t0gFmU9CZ539e7ibsYuo2s4Ge/cXeO+z576u6pusRch97z
         orpLvAedPbja2v1mTSlPnhjTOpx+1mv4sjiqKKCP9N/biaUMMUIXZeqWb2QCZK665e7p
         JwDw==
X-Gm-Message-State: AOAM533n4a+Bkmh+ne0kOJbdfhbDzZf13aF0TSlA2XBcBtE3pHTy2HRW
        gNvuS9V0jHIdIc13t8SmpxY=
X-Google-Smtp-Source: ABdhPJwsI+1paYwGaFzDwlAO14eiQ4fYT9LWvjXVci//0s0p1BVhw2EugH1zomzKfGcgbezrP3ENSA==
X-Received: by 2002:a62:2cd7:: with SMTP id s206mr18998392pfs.305.1591723819138;
        Tue, 09 Jun 2020 10:30:19 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 85sm10545242pfz.145.2020.06.09.10.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:30:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 630E3403AB; Tue,  9 Jun 2020 17:30:17 +0000 (UTC)
Date:   Tue, 9 Jun 2020 17:30:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: two more fixes for sysctl
Message-ID: <20200609173017.GQ11244@42.do-not-panic.com>
References: <20200609170819.52353-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609170819.52353-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 07:08:17PM +0200, Christoph Hellwig wrote:
> Hi Al,
> 
> two more fixes for the kernel pointers in the sysctl handlers.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
