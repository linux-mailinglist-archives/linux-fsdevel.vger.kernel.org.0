Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F021BAA5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgD0QsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 12:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgD0QsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:48:22 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6655EC03C1A7;
        Mon, 27 Apr 2020 09:48:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z25so27289881otq.13;
        Mon, 27 Apr 2020 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAyf44/4YFerP6DJWfqRXTjmOvbL2XaDORjOFH9i/rI=;
        b=qHJgEUdJIcVHT9XThDUGjp4X3Z1xHboytYlAyasNY5XMV9a3mT6fXN692D7wxqUNl9
         cnpqXLhr4lk5FbifZ9/L95vsbCX/d8b9DZLaRZIQbXO0Oslt7oXt3u70DII/49zxOorW
         Ub2kN/8xdeJpNK/4q4Hgtwj6QyMzE6fhi7nahBMD1zx42M75/oTciu5i5qmQMbe/lbsm
         97bFAI09fZTLbzqBVayqRqMKdpcFXree90j7HM4vwiy8jPqsLcfSRGHJ9yxerQlC/8JL
         I8pX64NTIDIvc9IP+azVyYP7jfs6aq9X8I5dbsJogb7yBaiwpoSi02cQdvzralDA1CBz
         JQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAyf44/4YFerP6DJWfqRXTjmOvbL2XaDORjOFH9i/rI=;
        b=dTlklMWfmhc89aXDYGbBb1Ji6m9OUFRIwougu4VNwbCa9hfEFzi4L+CMDR55OIIVLA
         SJBLKGwe8eawRJhvK66AkY8GgvEpaBBQihL7pP9diu2hIUAeKNPFnoLTwINHVs+mEeim
         olr6eO4RgA34nlXXqPgaKqP1uDLYzR1fImimpaDPrTNiJ4xWuAd1gRoAn2p9k1rftaLB
         ZGOXlt5EhTf6FGpT5NcIJiS182mj7NhoV8JIe67XzzLfzd9UqRGrpOyMxIDospnW1iNE
         O6wFN8xZzOtZU+5vr5gJRxXKIKXfCV5/x0kwzJUGJ6Jos01/mYGMLg+Kd5HFw7JDTeq4
         r5PQ==
X-Gm-Message-State: AGi0PuYpTPcoKXqv82RWA8+AjPhuhjeYb0ARr/B9GcVzNU6m19ca3J5K
        Zzq7LPF+dSH7LazG7McnN8Fpgh2dmOqQ/JTiSTk=
X-Google-Smtp-Source: APiQypI6eE1PRMGPPRVRi0P78QJf4KmHjGzbOMv5jJZl19CHYq3n4JYMcF7smsbV/VRtNFlp/scmHNAe5K6QyjReMxo=
X-Received: by 2002:aca:4e10:: with SMTP id c16mr16536872oib.140.1588006100850;
 Mon, 27 Apr 2020 09:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
 <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
 <alpine.LRH.2.21.2004230253530.12318@namei.org> <6fcc0093-f154-493e-dc11-359b44ed57ce@schaufler-ca.com>
 <3ffd699d-c2e7-2bc3-eecc-b28457929da9@schaufler-ca.com> <8bef5acd-471e-0288-ad85-72601c3a2234@schaufler-ca.com>
In-Reply-To: <8bef5acd-471e-0288-ad85-72601c3a2234@schaufler-ca.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Apr 2020 12:48:09 -0400
Message-ID: <CAEjxPJ66ZZKfAUPnUjQiraNJO0h=T3OTY2qTVPuXrWG9va1-2g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Daniel Colascione <dancol@google.com>,
        James Morris <jmorris@namei.org>,
        Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 12:19 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 4/23/2020 3:24 PM, Casey Schaufler wrote:
> > On 4/22/2020 10:12 AM, Casey Schaufler wrote:
> >> On 4/22/2020 9:55 AM, James Morris wrote:
> >>> On Mon, 13 Apr 2020, Daniel Colascione wrote:
> >>>
> >>>> On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
> >>>>> Changes from the fourth version of the patch:
> >>>> Is there anything else that needs to be done before merging this patch series?
> > Do you have a test case that exercises this feature?
>
> I haven't heard anything back. What would cause this code to be executed?

See https://lore.kernel.org/selinux/513f6230-1fb3-dbb5-5f75-53cd02b91b28@tycho.nsa.gov/
for example.
