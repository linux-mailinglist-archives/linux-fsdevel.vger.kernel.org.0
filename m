Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E4F7B2F25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjI2J3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjI2J3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:29:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74221193;
        Fri, 29 Sep 2023 02:29:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEC3C433C7;
        Fri, 29 Sep 2023 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695979742;
        bh=I3evYhopf4FBwIBsBJOYIcWYKXSYNLb1O/obNWVt13s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsgXbrwCUElWOwaEkt8r08dBOAOv0HoiHP9eO9xDZ5LKYeF6M7/mE+DnLfqE8uTIf
         BPegZjCVtTCR17yqHgWwWcU4hWrONzvZDt5ikQao4ypBWOJqHovx9Hl8KCrCdJtiSI
         95CO1OSVn7e2UfQ0r67iTS0hUOxte+OM8SZ8GsX5dAomAzXuD0Fw8t1RlGgBbCzFDI
         QG83BuHm1jANZuAJ6/MgAlxXvI3ttRv5yuNKxcQ1fsNQ6GR03lpKsBuvPBnUIfiDVe
         aTSXsOenAOudDIkIBd21KDjxTG3hd8xn6GzYclWFKgvQAI9Am/K98PMQA+lxG0vvIl
         IJsu0WPlhWs4A==
Date:   Fri, 29 Sep 2023 11:28:56 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] fs: simplify misleading code to remove ambiguity
 regarding ihold()/iput()
Message-ID: <20230929-verkraften-abblendlicht-b4b67ccd45f9@brauner>
References: <20230928152341.303-1-lhenriques@suse.de>
 <20230928-zecken-werkvertrag-59ae5e5044de@brauner>
 <87il7tz5zt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il7tz5zt.fsf@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Could you please double-check this was indeed applied?  I can't see it
> anywhere.  Maybe I'm looking at the wrong place, but since your scripts
> seem to have messed-up my email address, something else may have went
> wrong.

It was applied it's just not pushed out yet because of another patch
discussion. It should show up in the next 30 minutes though.
