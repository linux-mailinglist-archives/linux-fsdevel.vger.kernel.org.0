Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A770B525A44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 05:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376880AbiEMDl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 23:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376849AbiEMDlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 23:41:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374162A26D
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:41:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y41so6561564pfw.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaD/7HsV0lHA07q8V2RCBkaHsJJjfnySNbAofgOVR+s=;
        b=c5Kb2dLIuZWvdFJVbRc2JEjzw2B2Dzf6Pnk5QeLzsmOpoGIwIXrpk2u4HDZxZATVcb
         RQCZB7AVQpilRtH7j3HgXELDOxJYJ9AKnOiXcozN38K+eOYCpZP4eAlTuzhX/IbcCHuF
         fD3vymdbg+d0WJZH2mnnTf1n84ziyZHJdMP43IJNspQjPgKbCRjFPWCi0TXAHs+tLuGU
         urDfcdgnspQ7g4DGHkyU07WM4OnHipWnDR8hHhzB2+jand1Ci74ZFyKlmSFQx8u+ZRJl
         /fHf7uqFlvRKRzQk/sbZFyLyxR/TYYupQSVu7Zpa7xukHKA19d6/I9LAJEHLHh9NSCHf
         9I6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaD/7HsV0lHA07q8V2RCBkaHsJJjfnySNbAofgOVR+s=;
        b=IpFSJKEfXVfO9QfOaRy9v+j16DuqJWD8pT/pQ5p47kBxpcdshcaSTvywe9mmFv4WW4
         GaetkIPPX8su11AFWlEt4+uFdqn+CV2VT6DOw17pZh/R0pB50mu0YEZ3R4cKygzrzI44
         6kFJ/BjvLrMb7MdjsjK38wFSEpTBbWrb3YpIp76sV0TZs4VzL+pk7J9Z2dHFPcrl6SOd
         hfYzgTukng5Ev69dcf+2Z7X/xCniAZ45GJGE+NE32xlkGyo3l+DSd0msTX5Eu1f9pneD
         gE41IOfX+4uTahW6Raoq4feGuiB6KueVnrhB/018erIE+J9ryHYxZKsJah180PGLqZcE
         4EZg==
X-Gm-Message-State: AOAM533aLpjfBu6a3meOSC4SWwzkRcJrhncNWTbh5dwGV3l87/HbWe79
        3h/Bu/5ixwwMPfDf3EoanC3ULUhRDnRTRZRdgSUPYQ==
X-Google-Smtp-Source: ABdhPJztXj3NI4LlWRYrTyoHNrGuFPmTDU30zBctcBdUbZiL2txSy8W/riK1TBgLzTUumv2yr+YHO2k/aNd90/TW10s=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr2395090pgl.40.1652413280701; Thu, 12
 May 2022 20:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220422224508.440670-1-jane.chu@oracle.com> <20220422224508.440670-4-jane.chu@oracle.com>
 <CAPcyv4i7xi=5O=HSeBEzvoLvsmBB_GdEncbasMmYKf3vATNy0A@mail.gmail.com>
 <CAPcyv4id8AbTFpO7ED_DAPren=eJQHwcdY8Mjx18LhW+u4MdNQ@mail.gmail.com>
 <Ynt3WlpcJwuqffDX@zn.tnic> <5aa1c9aacc5a4086a904440641062669@intel.com>
In-Reply-To: <5aa1c9aacc5a4086a904440641062669@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 12 May 2022 20:41:09 -0700
Message-ID: <CAPcyv4hOD--eFPX9v4U0iowzQZVfOX2KgNYQU7Cb+WSnZmWpiw@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] mce: fix set_mce_nospec to always unmap the whole page
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, "chu, jane" <jane.chu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>, "Wang, Jue" <juew@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 10:17 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> > I - just like you - am waiting for Tony to say whether he still needs
> > this whole_page() thing. I already suggested removing it so I'm fine
> > with this patch.
>
> IIRC this new patch effectively reverts back to the original behavior that
> I implemented back at the dawn of time. I.e. just always mark the whole
> page "not present" and don't try to mess with UC mappings to allow
> partial (but non-speculative) access to the not-poisoned parts of the
> page.
>
> If that is the case ... then Acked-by: Tony Luck <tony.luck@intel.com>
>
> If I've misunderstood ... then please explain what it is doing.

You are correct. The page is always marked not present as far as the
page-offlining code is concerned, back to the way it always was.

The code in the pmem driver that repairs the page now knows that the
page is to be kept "not present" until the poison is cleared and
clear_mce_nospec() returns the mapping to typical write-back caching.

There is no support for what the UC case previously allowed which was
reading the good lines around the one bad line, just handle overwrites
to clear poison and restore access.
