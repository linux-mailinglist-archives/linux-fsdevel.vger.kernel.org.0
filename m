Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37003D0962
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhGUG1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 02:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhGUG13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 02:27:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31CEC061574;
        Wed, 21 Jul 2021 00:07:07 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k11so1255505ioa.5;
        Wed, 21 Jul 2021 00:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQFwt7gxtHzd25YAAbBq9bLGklSRxkB0hJRi8vFv0lo=;
        b=rxfclDiGAgJ6SpBve3jOsbQJGI+H90cWK053UHsBSgT7pWT/toQqdNs7K37KkCJco0
         7zoX41XwpIwXYlLcIzcMncFfCyv3GY86/xvWELsw2CWep7FJxPAwoJDikPDAPZkaYFnK
         KG0ZCjPpXz8yM0faqjhPIzc/jlxb1K1Hjw1w9xDauvF4eVnAtkT24n44iJ24Qo1iKJy4
         bQGpWV3TL9AQOGigprG5kHfWFQYg77cCX+4Q9kWKDjIECLFL2hkikIOqR28ObInVd9l8
         qcnxHUpNOMBj34NAVBg+vZBi8EELKxm/opoDm/A4RpQioWLZM5v2wKiGvORZd+JQFFiJ
         ul7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQFwt7gxtHzd25YAAbBq9bLGklSRxkB0hJRi8vFv0lo=;
        b=ocKqOie19CB8mlMUHzrV6u626+S2CvQ7HnaYrGTOAnLhF8uQxR7Y7ThGMJheLnbLZ9
         QBs+Abo7LoQxuXAuwoq2UXN3FdG8A7EvOY8DvMaHder3qlh+NovHpek7F8OYrKAs3KK+
         sTU/lgko98z8XVri9jUL7qu/1cnlAV2etBnrRuk9Tbw7opWTfesHr/ZX7+1dMKRV4410
         846SzXkYVT/kH2/EtKAa6vsade1SaEVtHJGdZo1H9rqGwE4c97vzJrBT80auRgGjtYba
         /iwzDG0uijr5s7hPS82MhZFJAh4ZK5Ol/sSJEUJmFHgjsvoMWJ1wk4DWdcd2kowtic9c
         lxgA==
X-Gm-Message-State: AOAM532ErrX+XfYbFtaIF++L21e2jWNdaAqlbCw1KWpZaIy8FmDrUUjR
        Z/VlxP3nQWIggE/rB/LYWKMn+zA6AaaAqHqq338=
X-Google-Smtp-Source: ABdhPJzTh087Z8o0mTV/0aqBP0TY5z9XzlbPe3zGzhCp7rEvUSiPFIJ6fa2JWbuN1HyMVmX2aaKs7DbZiEU+zHzvED4=
X-Received: by 2002:a05:6602:146:: with SMTP id v6mr25777583iot.5.1626851227171;
 Wed, 21 Jul 2021 00:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com>
In-Reply-To: <cover.1626845287.git.repnop@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 21 Jul 2021 10:06:56 +0300
Message-ID: <CAOQ4uxhBYhQoZcbuzT+KsTuyndE7kEv4R8ZhRL-kQScyfADY2A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 9:17 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> Hey Jan/Amir/Christian,
>
> This is an updated version of the FAN_REPORT_PIDFD series which contains
> the addressed nits from the previous review [0]. As per request, you can
> also find the draft LTP tests here [1] and man-pages update for this new
> API change here [2].
>
> [0] https://lore.kernel.org/linux-fsdevel/cover.1623282854.git.repnop@google.com/
> [1] https://github.com/matthewbobrowski/ltp/commits/fanotify_pidfd_v2
> [2] https://github.com/matthewbobrowski/man-pages/commits/fanotify_pidfd_v1

FWIW, those test and man page drafts look good to me :)

Thanks,
Amir.
