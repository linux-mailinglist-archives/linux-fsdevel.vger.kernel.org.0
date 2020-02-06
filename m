Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7EA1543CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 13:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBFMMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 07:12:49 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33092 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgBFMMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:12:49 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so6065496ioh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 04:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdjmz8xQ4W39FfZGura6JJv19gcFPdnlpa8vdTyKdqE=;
        b=HkomzyR9nZYhbivVmzCjI21V8iFL5CpopwIxdrbFUmGi/kF9IJMdLulLRCVTFFyEfO
         3yNObwc2yDxl3hEcuGt4ehQ7V579gT9JmmzVHuYdlDY0XJQzt4AbcDGknrgukozV+mEH
         cwl4RbOY2eHXadezJ0EMYi68I97YnnNXZdC7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdjmz8xQ4W39FfZGura6JJv19gcFPdnlpa8vdTyKdqE=;
        b=tbqLM574LY09MLE345BssW9rfZ2KJ+PqZw5ACQuNtuZvpbEm4MavQVDyvcJapWBGDq
         mMvKSmfocNU/lcUT1e9lgzS7pSj/T+nyCUr4seN8rhlrLnyhBBcMbMgS8UFziKrMGg84
         4rNzKzuHrhjnw5aMKynvPBK3ALyjgPvRQri+jXRwe9scBrWL/t2ALp+oFyW1jOHp+B0v
         +XoRr59eUfaaKBiOAEQOr0Cl5IorBHniYgMgNY0dG44lCjAFww/0fotUM5BgZVpJnWY4
         W5UElLrcDEurTtBcUo1YhpDuoFEW7iX+4AzgpG+VTzoI3o80HhyrYwen7AxMOxNH0oN/
         wlJw==
X-Gm-Message-State: APjAAAWG2OKkajvn86szPsoud/Pg0gflryE62Ia5CBsBirWmIuXIj6aS
        aDh6HA0b07+KLG0riU2t9pwQ2UMfEg5/Gimw61J3Fg==
X-Google-Smtp-Source: APXvYqyWo36JxRvwnwbq5WW32UFRhV+g6FJFCfS8osUpExOeYOY8dcPjRz37JMn4p0nqnnGKM6IkdT6k5oi2buaakKc=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr33238581jac.77.1580991167546;
 Thu, 06 Feb 2020 04:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20200205131546.GA14544@redhat.com>
In-Reply-To: <20200205131546.GA14544@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Feb 2020 13:12:36 +0100
Message-ID: <CAJfpegufhOneQqGRhoXHXau7Pz7H9k4WkkZwdSbDTM8_L5t6dg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Support RENAME_WHITEOUT flag
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 2:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Allow fuse to pass RENAME_WHITEOUT to fuse server. Overlayfs on top of
> virtiofs uses RENAME_WHITEOUT.
>
> Without this patch renaming a directory in overlayfs (dir is on lower) fails
> with -EINVAL. With this patch it works.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Thanks, applied.

Miklos
