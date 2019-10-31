Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C51EB21A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 15:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfJaOGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 10:06:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43022 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfJaOGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:06:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQB5M-0004Vk-2W; Thu, 31 Oct 2019 14:06:00 +0000
Date:   Thu, 31 Oct 2019 14:06:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Yi Li <yili@winhong.com>
Cc:     linux-fsdevel@vger.kernel.org, Yi Li <yilikernel@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seq_file: fix condition while loop
Message-ID: <20191031140600.GL26530@ZenIV.linux.org.uk>
References: <1572521901-5070-1-git-send-email-yili@winhong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572521901-5070-1-git-send-email-yili@winhong.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 07:38:21PM +0800, Yi Li wrote:
> From: Yi Li <yilikernel@gmail.com>
> 
> Use the break condition of loop body.
> PTR_ERR has some meanings when p is illegal,and return 0 when p is null.
> set the err = 0 on the next iteration if err > 0.

IDGI.  PTR_ERR() is not going to cause any kind of undefined behaviour for
any valid pointer and it's trivial to evaluate.  What's the point?
