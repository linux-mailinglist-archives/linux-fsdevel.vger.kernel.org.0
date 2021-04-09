Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11E635A055
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDINvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbhDINvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 09:51:00 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB54C061760
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Apr 2021 06:50:46 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id u29so2938708vsi.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8RoAP1EiR/LcGsXbxnBBCjPu3U5eRJLQXStV3VL6kw=;
        b=panrMHI79cDH7dTlwdn1I3IGqUb9am4TAQaZFV2Q0SFp7/bM44yhhHQikyWizy4e3g
         gnsRXzw9YnJSeQrRTFKzSQLvibLJR+aDeY4xdbNhgur3ipBxNqb/bmDe5j595DUGRXs3
         oN1fMt8Wvylbxj+Pggxqa2ifLXkeSmP4SdY3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8RoAP1EiR/LcGsXbxnBBCjPu3U5eRJLQXStV3VL6kw=;
        b=PaMGUUyljiBes0a1WiE3nvlSWPpULwygcknHTXM5lRxXG3Y7zyQF+DzS2M0vGGe6lH
         Ep/Z6jH6Y0462s11x8lIV5WoKAwUbm7Vy6ZZedWaFZzeEmH9giO2KF63OGwQ9HkSMz3d
         WFPVW+WL7d4xW4OoGnwhF0G7kh85K0bHBlUy9O16IH7GxcfnBv9v4Vm470s1Xi+UjH9b
         xRVtlsKAjO3ZZe3WlvA3UOm99Fj4P23N0WYoJjprqmWRJ7A3SbIiJ4Hc0RCQVSJ/WJV0
         gJh+RIjanJaOukvt8E90AmCQUgMkqTZ9Ge62exbqiNNik+aBC2uuvKfICT3Mid9IzJLW
         v2mA==
X-Gm-Message-State: AOAM533TY9cpchG8fD7zG8Myy8QhZ2xs2ry9XV0yD73CUWcLTUCph/fF
        A+BxnYlDDMlXaUkWqeylv135MrpaaWbi1QcAZOR8cA==
X-Google-Smtp-Source: ABdhPJwI4caeqnFFIu4i21Ymw4kHKa1nHUINrWzbVZD02yAE8tX+rdFIAOGmqoLfUUGSnEdfy4+9sdAFwYfcDywJoek=
X-Received: by 2002:a67:f487:: with SMTP id o7mr11201561vsn.7.1617976246033;
 Fri, 09 Apr 2021 06:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-8-cgxu519@mykernel.net>
In-Reply-To: <20201113065555.147276-8-cgxu519@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 9 Apr 2021 15:50:35 +0200
Message-ID: <CAJfpegtpD5012YQsmFEbkj__x52N4QrV0jSi=7iZtREqVf3tcA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/9] ovl: cache dirty overlayfs' inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
> Now drop overlayfs' inode will sync dirty data,
> so we change to only drop clean inode.

I don't understand what happens here.  Please add more explanation.

Thanks,
Miklos
