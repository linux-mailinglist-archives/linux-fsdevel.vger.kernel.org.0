Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E06A662B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 04:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCADD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 22:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCADDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:03:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDB719A1;
        Tue, 28 Feb 2023 19:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0C5AB80EF8;
        Wed,  1 Mar 2023 03:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570D0C433D2;
        Wed,  1 Mar 2023 03:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677639780;
        bh=KST7kuGKBwNQWupUzWrtCxf1pKhAzuYaNHh5QTYxFXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbX1GVAhPCGRaHFDjmoz8brUemPhyIiPN4chFPJgQctN/0qjaw1XwkcTVmuSE8tvh
         WHh1qgxNH9oPfvdy36fJPWhGnD09p2GhjMaJoIASWRov8UWPEfI9dDfa1gdjDyPHJT
         hKEcd3mEGOeiYt2SWcdaZJ+tJGkIJPB0OiAJlSoJDdg3Oaq6GttJ4q6ozMf4HlVJtL
         chMMX1j4AIi8nVCmhYD7YFrBOzlrqnGp6dubad5re4U/EzVQ+ggLJKT5Y5gL70PM25
         9TeUqXNXGpO/QrC0iw8nskX2b4jlyRfQ9Eg9b0zGuzS0yZHAg2j/ZB88OyGJJ8qRjv
         N8LYqTe4F0itw==
Date:   Tue, 28 Feb 2023 19:02:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cxl@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        code@tyhicks.com, sfrench@samba.org, jlayton@kernel.org,
        chandan.babu@oracle.com, josef@toxicpanda.com, amir73il@gmail.com,
        palmer@dabbelt.com, dave@stgolabs.net, a.manzanares@samsung.com,
        fan.ni@samsung.com
Subject: Re: kdevops live demo zoom & Q&A
Message-ID: <Y/7AYyUY65lLOl39@magnolia>
References: <Y/1KnN/ER8pnhbaa@bombadil.infradead.org>
 <Y/5O0yItfBwNKdXm@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/5O0yItfBwNKdXm@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:58:27AM -0800, Luis Chamberlain wrote:
> On Mon, Feb 27, 2023 at 04:28:12PM -0800, Luis Chamberlain wrote:
> > To start off with let me propose a few dates for this zoom demo (all
> > are Wednesdays as its my most flexible day):
> > 
> >   * March 8  1pm PST
> >   * March 15 1pm PST
> >   * March 29 1pm PST
> 
> Based on feedback to at least to get some EU folks I'll change this to 9am PST.
> I know one person can't attend March 8th so the following dates are
> remaining:
> 
> * March 15 9am PST
> * March 29 9am PST
> 
> Let me know if this works for those who had expressed interest.

Either of those work for me. :)

--D

>   Luis
