Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB25C7299CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbjFIMWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbjFIMWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3430C5;
        Fri,  9 Jun 2023 05:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEAB265786;
        Fri,  9 Jun 2023 12:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927B6C4339C;
        Fri,  9 Jun 2023 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686313319;
        bh=InEYsIeHNlgon49klc89kz3kVysYQBTJmADU7/l+htk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r1DCmdIqDPqASxI35kUB7B66kJdKMsoFcuUy7+9Rn/Z45g7P9ZDFqGHY/aFwYOpSI
         XuEGBccZJGnNA9f+SCbLGzn8GjBqk9pNeSRkKJG9Fps7aMSB3OyC0rbgnevAMtpuPt
         HtLDbAh28+/26MVslI5e9VFQAQQmszK5zDTyb7r8=
Date:   Fri, 9 Jun 2023 14:21:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Ariel Miculas (amiculas)" <amiculas@cisco.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Message-ID: <2023060921-underarm-crux-eaff@gregkh>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <CANiq72nAcGKBVcVLrfAOkqaKsfftV6D1u97wqNxT38JnNsKp5A@mail.gmail.com>
 <CH0PR11MB529931E71B5227AC6C49B737CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR11MB529931E71B5227AC6C49B737CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 09, 2023 at 12:11:14PM +0000, Ariel Miculas (amiculas) wrote:
> Sorry about that, it seems like I need to switch to plain text mode for every reply in outlook, which is annoying.

You should also turn off the top-posting mode, as that's not good
etiquette on the kernel mailing lists for obvious reasons :)

thanks,

greg k-h
