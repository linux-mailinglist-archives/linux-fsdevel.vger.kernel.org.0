Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D774198D30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 09:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgCaHjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 03:39:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43378 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCaHjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:39:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id k5so8471545oiw.10;
        Tue, 31 Mar 2020 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mAUnvEZguD6CfDl4gHndNC/T8IwUXTZiBxjH+at4TTc=;
        b=BAOCWSpovHS0fIzkHaAGLyJ47omoO1No0w6POuhEJhxM3BQxFtCIbzRCWf0zPfRKRj
         6OfEIHVk/j/rjUqoxjuMMF52nXczqJ10r9iCobz3HDYqDefLXsR0OmFWRzwCSJ92irbY
         wgfj+acI9+lHCdVUNqwdpXeAUGiRBMHhzj2UQzE8JNtJ0zXrUJfAailu6TWp0wVENI62
         4wKj0ufFmyVbBDCHUuOkoFg5ldXn9aCiJmKw/oYb1eX8X+1itIRLQ4F0BdeQxwI0zyDD
         g3hzQ1XGclY9h+WnU1WHf5w3/COjdbxDJ5A3J/bdu+sVRswlryTgdni4TcbkplX+tEop
         RGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mAUnvEZguD6CfDl4gHndNC/T8IwUXTZiBxjH+at4TTc=;
        b=jNB7VHJAAmtfAWuD5t8iA+VIXhP1lWhBkF8hFiHjKU1OX6Zh1KuNL4S8bDxr0HWZY+
         BZHJYY22pk7VRGbmPoHMfEq18UlfCjXMz8C1BRlvaCDcnB+G56iJL435ZATsNUvbETJu
         fimBL9DG88PKXAlvYlJObgd9Vr6+i780lOizWAKjM3dneNYGsgQHadqA5ec8O77mT83g
         1K2ivMaC2AbnaueUqrG3f1F9awlTpqncFE3+W30Cl1/j8jxZmnVFCooxbQzC/+h76ezQ
         kI2RtCJkcdSN437uE7akTg3o6qVzynTn6bVoShfoXEfSO67VsrTjbPEp4NwTUWUpO3aL
         cvPg==
X-Gm-Message-State: ANhLgQ0rIrFRmrOMJP6bF4iQnVk9u3Y5IhLCIKthv2BxbOJRku7fehMR
        xvvgOLRmi4cR070RWrjX4po=
X-Google-Smtp-Source: ADFU+vtnEAPociO8YfQmbNs0FQoZh40NVXPYe+BT18z9nE1Y7XHAgXGynisBg3O1sZtZwTgULToJvQ==
X-Received: by 2002:aca:c3c1:: with SMTP id t184mr1222939oif.113.1585640381659;
        Tue, 31 Mar 2020 00:39:41 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g39sm5084010otb.26.2020.03.31.00.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 00:39:40 -0700 (PDT)
Date:   Tue, 31 Mar 2020 00:39:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: mmotm 2020-03-30-18-46 uploaded (freesync)
Message-ID: <20200331073938.GA54733@ubuntu-m2-xlarge-x86>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <a266d6a4-6d48-aadc-afd7-af0eb7c2d9db@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a266d6a4-6d48-aadc-afd7-af0eb7c2d9db@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:18:26PM -0700, Randy Dunlap wrote:
> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
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
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> 
> on i386:
> 
> ld: drivers/gpu/drm/amd/display/modules/freesync/freesync.o: in function `mod_freesync_build_vrr_params':
> freesync.c:(.text+0x790): undefined reference to `__udivdi3'
> 
> 
> Full randconfig file is attached.
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Hi Randy,

I am guessing this should fix it since I ran into this on arm
allyesconfig:

https://lore.kernel.org/lkml/20200330221614.7661-1-natechancellor@gmail.com/

FWIW, not an mmotm issue since the patch comes from the AMD tree.

Cheers,
Nathan
