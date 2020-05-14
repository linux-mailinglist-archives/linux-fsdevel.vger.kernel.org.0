Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791821D349F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 17:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgENPKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 11:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgENPKr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 11:10:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D09C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 08:10:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZFVV-008JKF-K9; Thu, 14 May 2020 15:10:45 +0000
Date:   Thu, 14 May 2020 16:10:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/12] vfs patch queue
Message-ID: <20200514151045.GC23230@ZenIV.linux.org.uk>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <CAJfpegtNQ8mYRBdRVLgmY8eVwFFdtvOEzWERegtXbLi9T2Ytqw@mail.gmail.com>
 <20200513194850.GY23230@ZenIV.linux.org.uk>
 <CAJfpegvouhYeok=VsUM77biQe_X4yD8873_K7j3Vjqf2ri02QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvouhYeok=VsUM77biQe_X4yD8873_K7j3Vjqf2ri02QA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 14, 2020 at 04:55:46PM +0200, Miklos Szeredi wrote:

> Nits from you and Christoph fixed, Reviewed-by: tags added, and force pushed to:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#for-viro

Pulled, in for-next now.
