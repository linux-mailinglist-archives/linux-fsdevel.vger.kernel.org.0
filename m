Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B31F4080
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgFIQSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgFIQSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:18:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9CC05BD1E
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 09:18:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so8208268pld.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ztrSjb9Hc0jDPbsrcCP9Go/9i0R+UcDFFdl7eZx/r6Q=;
        b=Wt0DGBGICEfKEaimVAhmarg/KGSjFyRO5TzqXO6XNLncSbl4O/fYj7iUOCtswpKzN+
         HevAzRySRopFcCSeXweK5e1PBXobSPbw5nH2EJMegFAuKaGoY8E1mOIVxh2aev2COv0t
         kmR/gG4ejJZ4/WNjHaoSiU7wu9Cj80+IT+LS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ztrSjb9Hc0jDPbsrcCP9Go/9i0R+UcDFFdl7eZx/r6Q=;
        b=bWdfjkrVVhK35CrX4K0YdldpqF6irupf/paXxWlfN+dV+JB6k/nqmBD5t1A7GgIB2n
         egdeys9DIBe2H6oY0q+V7jZl+fCvUNZUSQtG0P63UPh/++/PywyBrtWwWDPV8NJqk3k2
         jyNCk82ImM8smOLJGjB+M9EYvGpnaOPgHfORC3UT1RTovkRp/zzH/DCCf5VQfnNOjn4a
         yvkjfhbtKT/QqO9dSrKVeT+xaGEcBaTru97JsFLoUTLMi7ruF7/N5oYSDjW44sCn937R
         soKB/WpP6oDjMX2YprOSzHQOgJz/h1b9PMUAAk08sRsMO7T6CP5QRmNj+mFOZfSCD/1/
         tpew==
X-Gm-Message-State: AOAM532VVzHJ/mTo9EtspXaaHhgsRUEqPUxpK7IFqYOiijnHWXbSPfsI
        14aWm2k9tUkb4JgWEMj/LzqsP9XJa5GjUA==
X-Google-Smtp-Source: ABdhPJzjmSmb72TVgOWLhqsjL+dd4r5fyjx7ZveMTCvaUG5Lp8LN8tzhQDJ3aYIZ5V3XnrmyX+A/dg==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr4086799plr.127.1591719530249;
        Tue, 09 Jun 2020 09:18:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm3136722pje.28.2020.06.09.09.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:18:49 -0700 (PDT)
Date:   Tue, 9 Jun 2020 09:18:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] afs: Fix debugging statements with %px to be %p
Message-ID: <202006090918.58395776C@keescook>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
 <159171921360.3038039.10494245358653942664.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159171921360.3038039.10494245358653942664.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:13:33PM +0100, David Howells wrote:
> Fix a couple of %px to be %x in debugging statements.
> 
> Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
> Fixes: 8a070a964877 ("afs: Detect cell aliases 1 - Cells with root volumes")
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
