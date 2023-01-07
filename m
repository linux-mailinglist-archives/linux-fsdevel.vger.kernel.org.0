Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA3660E04
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 11:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbjAGKnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Jan 2023 05:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjAGKnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:43:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5D2AD9;
        Sat,  7 Jan 2023 02:43:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5213760BA6;
        Sat,  7 Jan 2023 10:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C8CC433F0;
        Sat,  7 Jan 2023 10:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673088183;
        bh=XpOCkUedls8MTdjSrA/+Wl0kCJpmvTJl7RSUOhz95QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrGk+fr9hIjPRt8WC/A7xn/PM6DGPuaarmg9X5Yleml3LKUKDOT8nTHrWIInnlKZ8
         ormbLfwbzftP29aQA8fTqXlEw6Mgo+yqDL2CMLV9EV3Z7Y4n2SlDfLcDaPwWbhQDug
         dO1q3JC13C/r2nHDsruUL87gOjMQWecFKIAFuhKs=
Date:   Sat, 7 Jan 2023 11:43:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Finn Behrens <fin@nyantec.com>
Cc:     rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Rust PROC FILESYSTEM abstractions
Message-ID: <Y7lMtA1OO3NX5bl1@kroah.com>
References: <4AE31CB6-53D9-45C9-B041-0D40370B9936@nyantec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4AE31CB6-53D9-45C9-B041-0D40370B9936@nyantec.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 07, 2023 at 11:36:27AM +0100, Finn Behrens wrote:
> Hi,
> 
> I’v started to implement the proc filesystem abstractions in rust, as
> I want to use it for a driver written in rust. Currently this requires
> some rust code that is only in the rust branch, so does not apply onto
> 6.2-rc2.

Please no, no new driver should ever be using /proc at all.  Please
stick with the sysfs api which is what a driver should always be using
instead.

/proc is for processes, not devices or drivers at all.  We learned from
our mistakes 2 decades ago, please do not forget the lessons of the
past.

thanks,

greg k-h
