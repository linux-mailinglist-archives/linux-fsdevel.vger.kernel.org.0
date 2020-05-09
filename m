Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BF71CBD9E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 07:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgEIFC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 01:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIFC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 01:02:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D0DC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 22:02:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so5214247pjb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 22:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PblejXFYFxaChyYzck5O6k4FzOta65rmQVFP7KD8dDg=;
        b=K0XYe8pNJk7c0tNMRMrjfQ0YToPM8NiUVzaX3KFDHke/snEmuq7h/XsZYu2ll9ki92
         6O7Wyzy0mbCS1pKi8Nv1vZHVLMOGsxEd6/5/Hat1vvegmDz6COknREZ/Ni/eX21S4YIi
         wVAoeWLD9ljworD0PqPubniB5hZ/u3V3GAbdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PblejXFYFxaChyYzck5O6k4FzOta65rmQVFP7KD8dDg=;
        b=dHpv19xfX9LXX/yWMGOhkwfO19I0ACAqfa6TpZ0Kaqh/OvbZC4eh5pTSSaq9Kou0C0
         9xC3rlybq4I2mo6Z4J1I+Khs6rBpd16Swkqy/jh8GT2fNDpmNxzdHWBjnll1M502YSr+
         KexwRpoHNZgVvXeA1RORSPSPKd3epqbIPjqYP1/Nz7cJXrTzPFFwXRSmvO0TqIuTpMNV
         7vv0e3/FE93ZBYMXj6uEoYAXhsfs8fbafTfIBwg7Zj3mU1SAkI1gjqmYsiO+ZO8EgtLM
         jbNbdt+Jn63Ocpm4kgLmW4G6/OGI+ecqT3lsew9e6OWlyQWr0e9eZ/gnt5ahIGWOCGLW
         apeA==
X-Gm-Message-State: AGi0PuagLps0XTPdAGM4jYH9vIqhdkoCf/mWNE6LESd7HNeevv0qDk1u
        dR2VywS83g+worPl6sTkYwikLA==
X-Google-Smtp-Source: APiQypLAaU8j2dfgoyTjdwUvgAM0rOftnLGVHd225WjjckGYvGjxKTrMgfHRMjG612pO3IvZcFj6bg==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr5390945plj.329.1589000574672;
        Fri, 08 May 2020 22:02:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm3415031pfp.34.2020.05.08.22.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:02:53 -0700 (PDT)
Date:   Fri, 8 May 2020 22:02:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/6] exec: Move the comment from above de_thread to above
 unshare_sighand
Message-ID: <202005082202.567DED45B0@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87mu6i6zcs.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu6i6zcs.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 01:44:19PM -0500, Eric W. Biederman wrote:
> 
> The comment describes work that now happens in unshare_sighand so
> move the comment where it makes sense.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
