Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265701585FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 00:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJXL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 18:11:27 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43014 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgBJXL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:11:26 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so5560599lfq.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2020 15:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHnULLRvzcnTmrApgk0J6kXZO0qLfuB4AVQHnM4cmAE=;
        b=esB/56n6Q/Msdc20g+jexMovttxt6hCUBxvlvmdqGEumLlcmF5aj3v38oGR21nFNxo
         cOk4ekYVR6FdU2NjqUfNrI3LKVvMII6sqM7sSRTkqviALl/XYnv7z0n+5b5yYI3Lni/Z
         pHlhrG3K7Bp+8RWOpjWHLKMsY1f7PTIEy4J/RPb301AvTHMZeUbf9QaVy+/1sChmohPn
         5sq+e6/X6b3sYiGh+ziR8racoEm4OmMe/es+FRFQCba4zTFopBh8xK7owBMwffjbGKty
         kt8xNXlsArGuuruRAvzftXBAFrERmdhUUoEdMwiUrXKqtFq9YOe+1lKW7UiPQs4r9v/n
         YlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHnULLRvzcnTmrApgk0J6kXZO0qLfuB4AVQHnM4cmAE=;
        b=PBxv+VmCfBBM4HdCN9bz4/Y89hWGYaXITM0FTu0iTA93s+T6bSk5w3Xi/Ok2JwT9r/
         12y7FBNqC1HJ7+3dPZx+b+Wa9rScHP90GHX8cAFeO6efP73289X6UxM2AMdRfxfH2KXv
         lUUiYyA0WTbLH33sXZz9SbseE6+Ja+cOaqP8WKlfnKeTqm5Sg5V/VU4hB/2wwHsgoDzp
         VZF6v3YEDQ5oCCGYm8bWBhE1QnxhXSFIQyTw+4nxPoDVv32FA53AB807v/rlS1/lqK80
         vXMMXY6/b541nuf8LmVK+FUkKIsHBKRwvKSndaQxPnu75AAUgHsoSKhCaqhs9YkrdAnN
         b3yQ==
X-Gm-Message-State: APjAAAXcx8PjTicw5Ky+2bCRV5RBdpUgpTGkGdSurKkoIzwf/k+gjo6B
        xkfoNwMwD3FNF39tgaSjTKETOrETQQWjtvFWm1J4Mw==
X-Google-Smtp-Source: APXvYqxiERXVniVJSVLKbVx/xqUKUzq4lPf5gqhBdctRYV5+IUwsgO7mOTwXnfu4yRdcGlrvRlDwJrZV+Drqhe6D0W8=
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr1781905lfs.99.1581376284825;
 Mon, 10 Feb 2020 15:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20200208013552.241832-1-drosen@google.com> <20200208013552.241832-3-drosen@google.com>
 <20200208021216.GE23230@ZenIV.linux.org.uk>
In-Reply-To: <20200208021216.GE23230@ZenIV.linux.org.uk>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Mon, 10 Feb 2020 15:11:13 -0800
Message-ID: <CA+PiJmTYbEA-hgrKwtp0jZXqsfYrzgogOZ0Pt=gTCtqhBfnqFA@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] fs: Add standard casefolding support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 7, 2020 at 6:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Feb 07, 2020 at 05:35:46PM -0800, Daniel Rosenberg wrote:
>
>
> Again, is that safe in case when the contents of the string str points to
> keeps changing under you?

I'm not sure what you mean. I thought it was safe to use the str and
len passed into d_compare. Even if it gets changed under RCU
conditions I thought there was some code to ensure that the name/len
pair passed in is consistent, and any other inconsistencies would get
caught by d_seq later. Are there unsafe code paths that can follow?
