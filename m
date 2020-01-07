Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A1E132537
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 12:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgAGLwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 06:52:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54588 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGLwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:52:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so18581088wmj.4;
        Tue, 07 Jan 2020 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1IdCp+152V00WOErsRkB6rIy+yW5jX9FlF/zgyki7Lc=;
        b=Tb/pEh7m9Jj4VrIvPmRy9mhjGxM/6ucedJ+SjAZKLVTQBNGwyEcvjeiVJ7FMwZFYSb
         SMi7DjXMxrWfJFtvgdk7/2HrKdgjskBKFNWFkvBgr6hn68LuztLJ5rW4IpvZvuAzo1z1
         7Q4IK2JBNJZjyVzNS3DiIgaepKAFc2y5p5UTGbUjFyw+K7XmxR+9hmxSH7LLUHaL5MqZ
         uMAb30l1cgvfGDS+SNahOyWU27KpSkmjZo8UYvSpGBj4E0F5aJRjKTx5bDVdsIPlYc68
         olmu6TY09muhPu3kSdCGyvSdEUxYQsBttyMf59RyVC3iRtO5L4Ea1KIgEEY+TG53OUG4
         3jBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1IdCp+152V00WOErsRkB6rIy+yW5jX9FlF/zgyki7Lc=;
        b=RLxQv55bnMfQetXQofgl9dZXzvUXTuhIh8qf6/TIOQPZY4juLTI2Oy2KWN3exs/d+y
         9U0o4sGYJuOQ0fslqVsEpLej/Hovt0KwXnCHh5kXl4WmrWbhxbKETYvH/8k16WaDPMl+
         c3YFoA0tjX6cKxqhgB3f/3wMcwszFqjXp6awCARESDh/eAk0tSGiCHohJoFnxGkHHgMm
         qdRQuovGOO070PazpIFvoZd2Ja0kysrurvihuPQS9O0FVHhzCQF2CVJtC1siyIhG7WNK
         7xCFmFIZvV9zNXDDS81QWlYxRvM8fUfFAmm22sk4l3zLDbjoNmb5m/tKOSV8eH+8z4XP
         DZYA==
X-Gm-Message-State: APjAAAWIo4+Gr5cXW/KSyCXl2YHW39J4+VQihOgj2ynnQiglW0F7Tgec
        S4Z4XpUbHEcoiTCtcw6plMA=
X-Google-Smtp-Source: APXvYqzGkqsU4rE5bx3mL5nGETgA3WSI91fdY+KKbLOlbZK81M5sfoX009kOMr39/exXSQAOF7iU+g==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr40399910wmi.107.1578397924103;
        Tue, 07 Jan 2020 03:52:04 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s10sm76968698wrw.12.2020.01.07.03.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:52:03 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:52:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200107115202.shjpp6g3gsrhhkuy@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
 <20200102082036.29643-11-namjae.jeon@samsung.com>
 <20200105165115.37dyrcwtgf6zgc6r@pali>
 <85woa4jrl2.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85woa4jrl2.fsf@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 06 January 2020 14:46:33 Gabriel Krisman Bertazi wrote:
> Pali Rohár <pali.rohar@gmail.com> writes:
> 
> > What do you think what should kernel's exfat driver do in this case?
> >
> > To prevent such thing we need to use some kind of Unicode normalization
> > form here.
> >
> > CCing Gabriel as he was implementing some Unicode normalization for ext4
> > driver and maybe should bring some light to new exfat driver too.
> 
> We have an in-kernel implementation of the canonical decomposition
> normalization (NFD) in fs/unicode, which is what we use for f2fs and
> ext4.  It is heated argument what is the best form for filesystem usage,
> and from what I researched, every proprietary filesystem does a
> different (and crazy in their unique way) thing.
> 
> For exfat, even though the specification is quite liberal, I think the
> reasonable answer is to follow closely whatever behavior the Windows
> implementation has, whether it does normalization at all or not. Even if
> it is just an in-memory format used internally for lookups, assuming a
> different format or treating differently invalid file names can result
> in awkward results in a filesystem created on another operating system,
> like filename collisions or false misses in lookups.
> 

Hi Gabriel! Thank you for your input. AFAIK Windows exfat implementation
does not do any Unicode normalization and allow to store any sequence of
16bit numbers excluding some "bad chars" as filename (so including also
unpaired half of UTF-16 surrogate pair) if such upper cased filename
(according to upcase table stored in FS) does not conflict with another
upper cased filename already stored in directory.

So based on your suggestion, I understood that we should not do any
Unicode Normalization even just for comparing filenames if it exists.

-- 
Pali Rohár
pali.rohar@gmail.com
