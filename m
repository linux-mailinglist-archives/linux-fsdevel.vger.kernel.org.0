Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFAE1543CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 13:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBFMMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 07:12:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:32992 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgBFMMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:12:05 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so6063296ioh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 04:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PFo107MqpbbZak5POBjNZ8ZnCLKs4Wt7KVl/7P0nms=;
        b=FgvG2cBIuhRKJYVrMa/jwc/mRGvUFzNfzs1L2dt7RKxcMe0F71IfHxnh1leuhq5e5J
         5D7npVeLlmQ1vg+FePwxEGtlslQ/Hwh5Uu013/3zR5G0nF3KxDVII++GDtUC5HbAOhgy
         lLPL/Qt547GWoblK22hLLNFIWU9B1EkzncNXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PFo107MqpbbZak5POBjNZ8ZnCLKs4Wt7KVl/7P0nms=;
        b=EjuKWANOoA6Dyfbjh6/Slm9tV2iGx091hVadxCOeNs1fQ5j3p0U8TITiTeTGdBLozG
         N7N0vH900LBFVUMMZO2d27emhRZXEXYzhQnCgmKBxFL5rRjI8p6ivpUBkGMtiOsETt7W
         Sg5ZLATm2++KyX4SPc9X+KC36LQFZ/uKeU3rTsu3jGFLY7mXSpDI53jXSDS9HXvriKvf
         XJfYZ0X1U8k0+w9liWHykF5cJOzv3Chx3gj/vBHp2HVwETLnHK+EVEbcL6+4ESwVjmpq
         rvtdSmkRIGmtpwY3V4Pe7/RPRI+Jf9Vruy/EqFZ8+dHaKnWnlhvk++8Qx5vUKcJGbRUZ
         bMxQ==
X-Gm-Message-State: APjAAAVDmJGFvB5Qrqxlm0kHUFxsiupEewBnKQnu2USVDBYz9C0F/iO5
        oaaJ/Yv3L4JEJZ82pObyFH0nGpyqkJfmORHIB46+OaQi
X-Google-Smtp-Source: APXvYqw+AafqWRMiNeMaK2ZzeSWCKa1a2AEyn5fU8XVpHAXFE2BlGUPEGrIU9uURygwuq1xiPd7p6YF9RY9131TQc3g=
X-Received: by 2002:a5d:9a05:: with SMTP id s5mr32229734iol.252.1580991124557;
 Thu, 06 Feb 2020 04:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20200129050621.700256-1-dwlsalmeida@gmail.com>
In-Reply-To: <20200129050621.700256-1-dwlsalmeida@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Feb 2020 13:11:53 +0100
Message-ID: <CAJfpegsBHEBX8D2Eyybxmg5XWWyALA5VpFYVT+Ov=gYKx2PvGQ@mail.gmail.com>
Subject: Re: [PATCH v5] Documentation: filesystems: convert fuse to RST
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, mchehab+samsung@kernel.org,
        markus.heiser@darmarit.de, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 6:06 AM Daniel W. S. Almeida
<dwlsalmeida@gmail.com> wrote:
>
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
>
> Converts fuse.txt to reStructuredText format, improving the presentation
> without changing much of the underlying content.
>
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Thanks, applied.

Miklos
