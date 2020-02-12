Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF85015B381
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 23:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgBLWTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 17:19:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39458 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWTw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:19:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so3590830oty.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 14:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dis948cwNeinxa8i/TYZYfG+/CyrEnlR5hu/DWa+ybM=;
        b=b46EwgQ/R4Tl9W16sVQuvdJ+VUDwriFCwXa3KSjZOhq76Dy3w5h6Lq+sonFgRm/ppe
         vajDhgYwlVxsR5eCnWEFRbF7N7feGjZrIyateWUVikpseV8vHMRXr+Oz5AErGiICjgcZ
         XF+AQuLHx51B06J20yCJ3+T0CQI0jXGi6oQ8uxiX8JJ3+hHIxAFD1ZFWdQvxoNwUkDDL
         FincZToToqiW2mxIQw6bCLdvPk2Q5aNc0hQZLgQZcR+9AuBWh3n59pwCTE3m22f5EVKm
         Ya5cW5aRZy/GUyJ5qJQPegHYcuAq/+VmhpnDoqWp33L4yK4a1iDCCTGKA3J47q4Z25/7
         Cinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dis948cwNeinxa8i/TYZYfG+/CyrEnlR5hu/DWa+ybM=;
        b=F9DAD9ZGTThQIVlvfSvQbciH1L8OEGyu2OOgQ0d0P8GOBRQaroTntCKPv6SOILJ2+i
         11o6VVqRzZFfvd5ZwPobdQDyHxTcwaW13mZA6DyI+852N8TMeeXItyRnMy7fWs5VweLo
         mhhSoGRGhxr8ufV8RxwiDnoU8zDV0JQLzTN1qIqxC8mIKnn8hWHD9c4vKVBSk8I9qnVK
         nafGOrSswQWKlHigYveoHrovE3VHdFyZQDqmbulWlVtoH49fvtiOP4wLrO5BgN63RXBN
         xWUJ3EI4RHLjtbpp1F6tEuN5sfwlIecfZc8OsmH744Cwt/bk9bgE7F5w8MTU0UOyxbSX
         MrVw==
X-Gm-Message-State: APjAAAUw9E7/WzVLlWXcT21EVxx9secoJXomaP45iY/2UkA4/1EHw3ip
        isdXycjaVGkdvhBAMh/5pDc17LNQujOIdYDE4dLtwg==
X-Google-Smtp-Source: APXvYqzahdz8u0mrV8cMT5K3uwhN1gYlwNca4QIvHQzgMplvT26wMLpUWuFEUdor4bWKKmEm6aNQoclQejkjoAHRw4g=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr10367504otl.71.1581545991929;
 Wed, 12 Feb 2020 14:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20200131052520.GC6869@magnolia> <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com>
 <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com> <20200202214620.GA20628@dread.disaster.area>
 <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com> <20200212220600.GS6870@magnolia>
In-Reply-To: <20200212220600.GS6870@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Feb 2020 14:19:40 -0800
Message-ID: <CAPcyv4gzGzgYxEDC-hjy9cy2M+V_t9VcALM3jmH=_K8XheOF-w@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Allison Collins <allison.henderson@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 2:07 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
[..]
> I've really really wanted to be able to tell people to just send a pull
> request for large series and skip all the email patch review stuff, but
> I'm well aware that will start a popular revolt.  But maybe we can do
> both?  Is it legit to ask that if you're sending more than a simple
> quickfix, to please push a branch somewhere so that I can just yank it
> down and have a look?  I try to do that with every series that I send, I
> think Allison has been doing that, Christoph does it sometimes, etc.

This is begging me to point out that Konstantin has automated this
with his get-lore-mbox tool [1]. As long as the submitter uses "git
format-patch --base..." then the tool can automate recreating a local
branch from a mail series.

[1]: https://lore.kernel.org/workflows/20200201030105.k6akvbjpmlpcuiky@chatter.i7.local/
