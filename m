Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C225F107C58
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 02:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfKWB4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 20:56:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41279 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfKWB4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 20:56:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so7876646oty.8;
        Fri, 22 Nov 2019 17:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fY97mssNbAeaJnSeJ7M7A2khmxP4s+EvF0WZGzWhLEg=;
        b=HpS9wGU0jSPTrbPJM8uiVLTycsT5dAMsJVw5oViQrC7O+wTxxLq6a9cBg7HyTCwITf
         2MPSHRoa9M4VfdZaQfiq3vUSjvqwSVu8SRaym9QdYlkzBv04y2stu80uyRZwCN6kGQNH
         OcLljOxoAkJ07ygSHPAnt7OT+EMh9SaUZoS/K4w/UkhzQ3YzdHGxWuAlSIScLQ/RXmBI
         rF9svIaX2/9sZkmASBDYGgXr0tUGTh+2w2/GCjuBzqBSW/HfYg3bMo6gJXGlL7sYCxiG
         gJwH9plzNFXjGlyzQ+wAKJkkVu7Pt/72Falw1bebhmiGLNiEhbKSC+TK4iGw5ow/8B6R
         IJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fY97mssNbAeaJnSeJ7M7A2khmxP4s+EvF0WZGzWhLEg=;
        b=WMsVBVmc7wCCN+H+9GUz2f/g0Y3/wBO3M/3j3ezkLMIIBDb0AHRRUO1UzCeJwgEeI6
         5HG1IOlDJolXmyRAFfXsTdXy9P7PFjMI+pWdfszq0oRCjzoOoGreEEjXq0trb0KVut1o
         7HE2nj/CdjD5sDiilN56AGHx5OXuP8NwuQbmslq9JXU/9PkdOuX0LBm4CxYsdb+AH9LU
         oorCSPESOy0OZuDDX0RVZrZbjTAsHutIi/Ic1xdLjBYS4cnMvY/N84AHkJS1egGuZ2FB
         a5qMHKY8dRY5OEHNSTdad0zBrj61IMYOSoj/Q5qnid32u5RqWOEDn8l85+f/JLghV6F1
         VlqQ==
X-Gm-Message-State: APjAAAWkKsgWunYSJhZXI0tKRvp32PvuDxCq4v6h7o7mKbXyxEuP9Nb6
        CNS1mWmAMfiDjSvkoBGB5yPEhNPsded//2dO7fU=
X-Google-Smtp-Source: APXvYqweuiDUAqKWWbHjUkQuHpDpE/vKYacYjR0QWYtVdKG+sYvDCaZENumf/zswBUvwMqXy8bBmlP7Oh1bdxLjuIbY=
X-Received: by 2002:a9d:66a:: with SMTP id 97mr13128755otn.114.1574474177107;
 Fri, 22 Nov 2019 17:56:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:3c4a:0:0:0:0:0 with HTTP; Fri, 22 Nov 2019 17:56:16
 -0800 (PST)
In-Reply-To: <20191122170202.GE26530@ZenIV.linux.org.uk>
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094021epcas1p16e9ebb9fd8a1b25c64b09899a31988b9@epcas1p1.samsung.com>
 <20191119093718.3501-4-namjae.jeon@samsung.com> <20191122170202.GE26530@ZenIV.linux.org.uk>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Sat, 23 Nov 2019 10:56:16 +0900
Message-ID: <CAKYAXd_FqMxUE2VtsASMcwNdMF+4wGkzkF0gRPSpKOkZYGYomg@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] exfat: add inode operations
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        Markus.Elfring@web.de, sj1557.seo@samsung.com, dwagner@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2019-11-23 2:02 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Tue, Nov 19, 2019 at 04:37:08AM -0500, Namjae Jeon wrote:
>> This adds the implementation of inode operations for exfat.
>
> Could you explain where is ->d_time ever read?
Oops, That's leftover from the clean-up that use d_fsdata instead of ->d_time.
Will remove it on next version.

Thanks for review!
>
