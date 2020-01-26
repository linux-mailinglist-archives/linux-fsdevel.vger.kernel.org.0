Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4E149B44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2020 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgAZPIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 10:08:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34885 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZPIO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 10:08:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so7843778wro.2;
        Sun, 26 Jan 2020 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=z79T6YhNfkWdwuKGiX5xKV0iKzoNVcE/b5/v1NUh0PA=;
        b=Eho0gL/Gipi0LehXFSZkSEk424FahnFpXjyjIZ1tPqbDpX5IUNyMBQkCvPCW4ohtOv
         DNYnrm+xxZ/EvOyfmUaxz4JlZKeMz3QwHdlzvuBUFnBjO59GdTCone4Sz5AmB5pJmXZX
         I85rYEI4ekuXrXZWHVEuJp1MjLuXnNxwgBeerNM3iOtY2+ZiPRmcDdqmiydOIROXjmXz
         KEWcr78db3hvV0Ke9xZD8AijE/HLmn0NTw/SklTO+Q05Ij4IO1qKqkVbD2ZDAO7BTPWh
         K/9SYQjdidsCrAmuPJLAj0H89Hj51M/4N190evEUSgeSF7hgL8yPZYG2seTlHPUEE8+2
         2e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=z79T6YhNfkWdwuKGiX5xKV0iKzoNVcE/b5/v1NUh0PA=;
        b=WhD7VZvn4aZIdpkBXTjMKmbPjb9XpbmAl8tTIczlo68Hk+Itsf2Q7ayGFh9oAjDIZo
         nMap2DK6FskD7NuC7QGDrtj806B6lwZK7d+ucbRwMlhqkpfE3i01ko7vL7DlMNPk1ekT
         HrUqW9InUay0Zd7iChjl64uPlyBAKrQgOtvcsT1NjnPf11XtKPzAoI57+FRPHla3jYxf
         vyl18Mw18uorvAYLGjqBa+boTtCyusFGNhC3Of6Yx/owTEF3HJlcbEyIsS0cXRPJ2anM
         NjHIJvM78DryXMVXmPpmACdl7IQ/hpVOKBXI8aewY8PfBi79oLHzSsr7fkPTUk94pwBV
         bI9w==
X-Gm-Message-State: APjAAAW3wIrA48kISKFLGwzQWU3DAL1xd7vHcqTT40/0h4Mhh7tkbBvu
        Om005+vsw6uX3o4pbGLszyXvVdE=
X-Google-Smtp-Source: APXvYqzYP0hQtEFeCLt+FlIM0Gd2a+sLwKcfWBGLQHO2C2P2pcFnV9LNlmdWc1XVOHxTR4SioLxb1g==
X-Received: by 2002:adf:df83:: with SMTP id z3mr15696286wrl.389.1580051292547;
        Sun, 26 Jan 2020 07:08:12 -0800 (PST)
Received: from avx2 ([46.53.250.34])
        by smtp.gmail.com with ESMTPSA id m21sm14940792wmi.27.2020.01.26.07.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 07:08:11 -0800 (PST)
Date:   Sun, 26 Jan 2020 18:07:57 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2020-01-21-13-28 uploaded (struct proc_ops)
Message-ID: <20200126150757.GA27267@avx2>
References: <20200121212915.APuBK%akpm@linux-foundation.org>
 <d18345b6-616f-4ea3-7b9e-956f8edc26b7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d18345b6-616f-4ea3-7b9e-956f8edc26b7@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:19:22PM -0800, Randy Dunlap wrote:
> On 1/21/20 1:29 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-01-21-13-28 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> 
> and when CONFIG_PROC_FS is not set/enabled, kernel/sched/psi.c gets:
> 
> ../kernel/sched/psi.c: In function ‘psi_proc_init’:
> ../kernel/sched/psi.c:1287:56: error: macro "proc_create" requires 4 arguments, but only 3 given
>    proc_create("pressure/cpu", 0, NULL &psi_cpu_proc_ops);

Thanks, Randy. I've checked current mmotm, it looks like no more "NUL"s
exist.
