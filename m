Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26E44857CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 03:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389724AbfHHBwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 21:52:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50146 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389718AbfHHBwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:52:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvXb7-000178-JO; Thu, 08 Aug 2019 01:52:09 +0000
Date:   Thu, 8 Aug 2019 02:52:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] fs/handle.c - fix up kerneldoc
Message-ID: <20190808015209.GM1131@ZenIV.linux.org.uk>
References: <8606.1565220154@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8606.1565220154@turing-police>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 07, 2019 at 07:22:34PM -0400, Valdis Klētnieks wrote:
> When building with W=1, we get some kerneldoc warnings:
> 
>   CC      fs/fhandle.o
> fs/fhandle.c:259: warning: Function parameter or member 'flags' not described in 'sys_open_by_handle_at'
> fs/fhandle.c:259: warning: Excess function parameter 'flag' description in 'sys_open_by_handle_at'
> 
> Fix the typo that caused it.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Applied.
