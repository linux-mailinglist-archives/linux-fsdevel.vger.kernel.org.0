Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0DC1D8006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 19:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgERRZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 13:25:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43558 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERRZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 13:25:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id v63so5251734pfb.10;
        Mon, 18 May 2020 10:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rf4+hBoD1TufFAfP8oFpnGmCmQq8DRRl+yC7GIzRnls=;
        b=NhQurF0swK75au3jCljjIk+T7onO26pMHv2X+vSZjOoBH+PNQNYM6pN8K+gTDEZi5r
         gc6C3rIhup07M9HZ6QHLtU+18fdR8+LQHASFX3zCJj5x4Iomr+4GIe4ctvYZ8FvWxhwB
         vh3kzdXPhKTTvlGwUuSGfVYq9vmNwKiwIshHZTACXLKMPr4OIjBIE4KM5A0C91bZj58+
         IixZBrJoVR9fxR41HHdg551iUxqR9NwDGyK154jj0n3EEKhaJz+HIXQGAsp9f4BPZOJV
         jpLte7c3x59G0Ax5aXjtRHBt0AJgcIZT8U0nJTtNbMy5CGWTS9jYdYRIYcwg0C40FXag
         FRsg==
X-Gm-Message-State: AOAM531jb8IziEd+kKN00T6NHLNsHe/s3zY/2sfK9Af0zuSqHzY99tPl
        r8WMdmnZOvk14Gk8GY+gnMo=
X-Google-Smtp-Source: ABdhPJwoIGmdm0EAOz7T19rzlTCGw86tRefARI9ZDYNn44SDMrYtVhJEFmKj0/1owuC3GWI0j0VyGA==
X-Received: by 2002:a62:e402:: with SMTP id r2mr18153266pfh.300.1589822711513;
        Mon, 18 May 2020 10:25:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c3sm3614080pgk.76.2020.05.18.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 10:25:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D0475404B0; Mon, 18 May 2020 17:25:09 +0000 (UTC)
Date:   Mon, 18 May 2020 17:25:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Kitt <steve@sk2.org>, Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: const-ify ngroups_max
Message-ID: <20200518172509.GM11244@42.do-not-panic.com>
References: <20200518155727.10514-1-steve@sk2.org>
 <202005180908.C016C44D2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005180908.C016C44D2@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 09:08:22AM -0700, Kees Cook wrote:
> On Mon, May 18, 2020 at 05:57:27PM +0200, Stephen Kitt wrote:
> > ngroups_max is a read-only sysctl entry, reflecting NGROUPS_MAX. Make
> > it const, in the same way as cap_last_cap.
> > 
> > Signed-off-by: Stephen Kitt <steve@sk2.org>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Kees, since there is quite a bit of sysctl cleanup stuff going on and I
have a fs sysctl kitchen cleanup, are you alright if I carry this in a
tree and send this to Andrew once done? This would hopefully avoid
merge conflicts between these patches.

I have to still re-spin my fs sysctl stuff, but will wait to do that
once Xiaoming bases his series on linux-next.

  Luis
