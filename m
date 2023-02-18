Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB5669BBDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 21:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBRUaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 15:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBRUay (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:30:54 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ADE14EA5;
        Sat, 18 Feb 2023 12:30:53 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 88602C01F; Sat, 18 Feb 2023 21:31:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676752276; bh=QadmvTLU3p7JOh7xxAC87K0Sg4e9FWFDYpVVA2/g8Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PE2pVytWtKc1Th+ESPKMPRo74U/rELp4CvbtYzaIozYZAJcnaF8aM23/KMqCPJGOq
         rvwid6AcI9H8I00NdaTbZwISZv6giZ7gYsi/lzsBpG76xGgxHjWM/6VY7FJJRiL5sg
         BSeInbfPyy7a+hV5oIqIxi9aK/RnSPWZ77KTcrtSdpv0ak8PHuZyA2imGKzNGnsJGL
         Cx+Wu3sMLgjAFgUx84ZfcTtwReJdoqPprwD+eRazHC8wr2nRXBeAOCd+gOS5WqtYeG
         adO1G0PEF1eRhvLj7FKS5b7K/Ffmre1GTOhncBQzbvshVXHigl5SyyQLMFhjAafg+w
         HiokfuTxvCtZg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 7AE56C009;
        Sat, 18 Feb 2023 21:31:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1676752275; bh=QadmvTLU3p7JOh7xxAC87K0Sg4e9FWFDYpVVA2/g8Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=obW/Wnv+FxbzyuW3FxZ5pKxtPWkJfWQZxT95elJwJecIdaWpIqrQ3KC4bCM3pqIrX
         24puNPh+wYA2CheNiu5dQdlshPRX/HUadH++EdDQpWR4OojpmAc042t6+09yaK9IB4
         5PyoqzT1wXTqxVOJZurWuo2DaG7eHi7tnbnvU6Nt4AJeKzWkmTRiJkFZ+b0y4gr22E
         X3PAcm60xDXqciCvZQz+i1LOv7fE95e490NfAFx6218bzfbNQ2jnchoKd1a5Pw4W/8
         0foPJf7cnDlI55283YzmdOIjCxVnx+Y3o0YsnQ+W2WA0y08gyLkp9qHOBmgPzLQRBD
         9WQiA0mn3AoUw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id a9e515da;
        Sat, 18 Feb 2023 20:30:47 +0000 (UTC)
Date:   Sun, 19 Feb 2023 05:30:31 +0900
From:   asmadeus@codewreck.org
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Subject: Re: [PATCH v4 04/11] fs/9p: Remove unnecessary superblock flags
Message-ID: <Y/E1Z0sdaS06GMaN@codewreck.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-5-ericvh@kernel.org>
 <Y/CbhQVeO8/pxrBE@codewreck.org>
 <CAFkjPTmBs10YAPrXYx3hQHvVu0P3+_fJ+_eZ+9z6h7csSqRYbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFkjPTmBs10YAPrXYx3hQHvVu0P3+_fJ+_eZ+9z6h7csSqRYbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 10:24:17AM -0600:
> That's fair -- and it didn't seem to hurt anything to have DIRSYNC at
> the moment, so I can drop this patch if we think its too much noise.
> I guess it was more of a reaction the filesystem implicitly setting
> mount flags which might override whatever the user intended.  FWIW
> SB_SYNCHRONOUS did seem to have an effect on behavior (although I
> didn't specifically track down where) -- I noticed this because the
> problems Christian found seemed to go away if I mounted the filesystem
> with sync (which basically ended up overriding aspects of the cache
> configuration I guess).

I guess it doesn't hurt either way; happy to keep this patch in doubt.

-- 
Dominique
