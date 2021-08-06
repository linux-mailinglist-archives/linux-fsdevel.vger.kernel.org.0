Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847B93E2BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhHFNsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 09:48:55 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40696 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhHFNsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:48:54 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mC0BA-007dWz-9R; Fri, 06 Aug 2021 13:46:28 +0000
Date:   Fri, 6 Aug 2021 13:46:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: optimise generic_write_check_limits()
Message-ID: <YQ09NFOPz/K3sDV6@zeniv-ca.linux.org.uk>
References: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc92d8ac746eaa95e5c22ca5e366b824c210a3f4.1628248828.git.asml.silence@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 06, 2021 at 12:22:10PM +0100, Pavel Begunkov wrote:
> Even though ->s_maxbytes is used by generic_write_check_limits() only in
> case of O_LARGEFILE, the value is loaded unconditionally, which is heavy
> and takes 4 indirect loads. Optimise it by not touching ->s_maxbytes,
> if it's not going to be used.

Out of curiosity - how much of improvement have you actually seen on that?
I can't say I hate the patch, but I'd like to see the data...
