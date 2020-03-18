Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 659701893D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 02:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCRBzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 21:55:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgCRBzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n8WaT2pi8h8ZeSpbZU79nxS0PDKpvFIPkib3B7Iy9xo=; b=cJRp34yqma1tSdCdEvUG3RzlW+
        nYLQAuW3ut+cPDQT+qgwMH9B8XbF05HmlF14rbg3fUUYk+O0ZJwkP3tlXZpu8S2UZjegPSJ/4UxlK
        yLesmu14kWTCCKYD1hwqoRlAb9Ru3e0iH+O/w2itPRsUDQZafc+BOPH9KXjd8pSJ8UhSdeWynFbw3
        aHG6M/3uBRhFh/vPgfyOq18gbUT2WgYr5kOsDBCeesBvlJ0azDAltFrgIRw3/OZxg0soJasZBJIbf
        C+iaRvCIMEomV+Eijyw4GyrvMZHD4VnF6PDmQhOC0zQ0rUgI+gkpMik1Q9F2QIlInRiWDo2dwdWmE
        pjL8taDA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jENw2-0004mi-1j; Wed, 18 Mar 2020 01:55:54 +0000
Date:   Tue, 17 Mar 2020 18:55:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] xarray: Add missing blank line after declaration
Message-ID: <20200318015553.GG22433@bombadil.infradead.org>
References: <cover.1584494902.git.vitor@massaru.org>
 <7efa62f727eb176341fc0cdfcd47c890ff424451.1584494902.git.vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7efa62f727eb176341fc0cdfcd47c890ff424451.1584494902.git.vitor@massaru.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:43:03PM -0300, Vitor Massaru Iha wrote:
> @@ -1624,6 +1624,7 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>  	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
>  		if (offset < XA_CHUNK_SIZE) {
>  			unsigned long data = *addr & (~0UL << offset);
> +
>  			if (data)
>  				return __ffs(data);
>  		}

Do you seriously think this makes the function in any way more legible?
