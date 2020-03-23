Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E315318F88A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 16:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCWP1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 11:27:07 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:38935 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgCWP1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:27:07 -0400
Received: by mail-io1-f44.google.com with SMTP id c19so14523812ioo.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2020 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBmuJ6QX/AJgqLMUrHdKFtDRnQy8fppYlKoGXEVertM=;
        b=A2Yhm8eLZUlXGw+m+XX4hbQ+vrkERRBTcOsMDKdXo+p2aMkoz6LK6YuDAK44bXCvXL
         xjGAV2RxSn/JKGnPLfxkQndFXKhakRPjfZs+6r8i/fcMVdxJBBHFGdvE5oNqPkPQGOAN
         AlhZEMNceMqpV9LJqZW/6fhpQXfnY/y2MAHW8LhB6EF/0NNQmF+fKrF8v+fxj0vljXgL
         9SnwnBLSScSXTe+yHrITD+2/S+63z34VI6KKplMFhl++0+ZM2yIihoNrM+aiQujwSRWn
         lsD//+XVMV8fC2tYRWjUnsl3vyvWgE4enFOK6t8Cph94No+JHyu7u8nyy2VhTIjF+yY2
         WUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBmuJ6QX/AJgqLMUrHdKFtDRnQy8fppYlKoGXEVertM=;
        b=nhuMGr6eGWaWCh8mRDbKwj/YR3k0PNucDOz8f9qUeT7N8puONobjs5GGmC+BecXVoj
         56/POFcMHFEuFHl9zFzODaq3Zqn+uLpUwKAk4ZrMSn3Im3c9B/1XYqyKxhpkcmytXQIH
         BzWf33GndwdAsr7CHigKwMgIorrqcXLduf+/+wT1Km4PuzsYyIIIynQFzgAAhUJ/fTLp
         1pgO503FiXXD/ltWA6fOq0v7n6oc/MzYXDb+d7mt3zGcwQ3OMWXFQRnaBgqlp12jOFX9
         XNUvd/uzTENHT9wwlrj52K0hoSc3Og+3btkaWRR/KsnvE06ZFmyVrSbq7uQnv+U0gAb8
         g6qg==
X-Gm-Message-State: ANhLgQ0OvCzJy0Oc09+FfpRldmhQUR2Hul3O4WnBAbj4w7e1HY2mx5nB
        49hYIYGnk7odvkzFUT0/IWbzSfwUkDdr8IrgYf0gWg==
X-Google-Smtp-Source: ADFU+vujebl7Cf4Gs66f1P1ls5+cXzJy/VUjXiBIfZwc2QwXG199PJUFFAHhKXLVfm0qO8I5p3lKkDrVoupN/wZRv6A=
X-Received: by 2002:a6b:cd4a:: with SMTP id d71mr19807418iog.5.1584977226574;
 Mon, 23 Mar 2020 08:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <TY2P153MB0224EE022C428AA2506AD1879CF30@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
 <20200323115756.GA28951@quack2.suse.cz> <CAOQ4uxixHS6p44DObK=raGjmRUjLVoCozhpv_H85gUcdftOeRg@mail.gmail.com>
 <TY2P153MB022430EDF9F91E7F457667739CF00@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <TY2P153MB022430EDF9F91E7F457667739CF00@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 23 Mar 2020 17:26:55 +0200
Message-ID: <CAOQ4uxiZE2xipfmSH45Y6LgAy-Uz6uLH+rsp3OMAJrsDqby9uQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Fanotify Ignore mask
To:     Nilesh Awate <Nilesh.Awate@microsoft.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 3:34 PM Nilesh Awate <Nilesh.Awate@microsoft.com> wrote:
>
> Hi Jan, Amir -
>
> Thank you for quick respond!
>
> Yes with mount --bind /opt /opt and then adding ignore mask it works as expected.
>

You shouldn't need an ignore mask if you did not set a mark on the /opt mount.
The mark on / does not 'recursively' apply to sub mounts.

Thanks,
Amir.
