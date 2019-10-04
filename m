Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD4CBF08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389697AbfJDPVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 11:21:52 -0400
Received: from nautica.notk.org ([91.121.71.147]:39956 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389165AbfJDPVw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:21:52 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 11:21:51 EDT
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 92FF5C009; Fri,  4 Oct 2019 17:15:03 +0200 (CEST)
Date:   Fri, 4 Oct 2019 17:14:48 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jiri Kosina <trivial@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RESEND TRIVIAL] fs: Fix Kconfig indentation
Message-ID: <20191004151448.GA19056@nautica>
References: <20191004145016.3970-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191004145016.3970-1-krzk@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Krzysztof Kozlowski wrote on Fri, Oct 04, 2019:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>     $ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Send this to kernel-janitors@vger.kernel.org ?

I can't pick this up as a 9p maintainer and most probably everyone else
in copy feel similar, this is stuff where they might be able to handle
this smoothly.

(I have no problem with the 9p part of the patch, so add my ack or
whatever if you feel that is useful, but it's honestly trivial as you
wrote yourself)

Cheers,
-- 
Asmadeus | Dominique Martinet
