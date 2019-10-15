Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E2BD7F26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbfJOSkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:40:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38298 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfJOSkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:40:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iKRkI-0000rf-7Z; Tue, 15 Oct 2019 18:40:34 +0000
Date:   Tue, 15 Oct 2019 19:40:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: copy_mount_options() problem
Message-ID: <20191015184034.GN26530@ZenIV.linux.org.uk>
References: <5DA60B3E.5080303@mcst.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DA60B3E.5080303@mcst.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:09:02PM +0300, Pavel V. Panteleev wrote:
> Hello,
> 
> copy_mount_options() checks that data doesn't cross TASK_SIZE boundary. It's
> not correct. Really it should check USER_DS boudary, because some archs have
> TASK_SIZE not equal to USER_DS. In this case (USER_DS != TASK_SIZE)
> exact_copy_from_user() will stop on access_ok() check, if data cross
> USER_DS, but doesn't cross TASK_SIZE.

Details of the call chain, please.
