Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E7E78FF85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbjIAOyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350073AbjIAOyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:54:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3CD10F1;
        Fri,  1 Sep 2023 07:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6815ACE23C2;
        Fri,  1 Sep 2023 14:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1766C433C7;
        Fri,  1 Sep 2023 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693580076;
        bh=NjwxTCm/jZ2eU51BgFry4cbLuNpDiz0CT8mjOyQgexM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tr9SjxLA4Ftu7kyN7WO5NTgJRmR7Q2RDTTJagwkYWiw+qbjDpKkb5pz8vi/5C+LlF
         y7UbLnisLHxl45vFEjlOvt5osdN7yAnVu/y68mpiys9r+/9WpxDIBJBHyqMdzKpLRm
         Lfzoo/G9JuoCyLdepnozBCkHUY+JiHmbR11lS+g1Tc91XBZ97TeLhM9SI4d35xEOl5
         cU2tGbMEwtVacVb/x8RlxuqP/0pDxaaq9cAsaoDGccP4B4flQ0VY8rL3+7y9AIZqtI
         XH0xKrBjm3VcEjHhNBSQE8U1PYfOFcAFJ/osIrBAhTl4QfokHATbJ8zJHRM02/jZ4c
         XioAAAwQDClqQ==
Date:   Fri, 1 Sep 2023 07:54:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Emmanuel Florac <eflorac@intellique.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [ANNOUNCE] xfs: online repair is completely finished!
Message-ID: <20230901145436.GQ28186@frogsfrogsfrogs>
References: <20230822002204.GA11263@frogsfrogsfrogs>
 <20230828143317.1353fc3f@harpe.intellique.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230828143317.1353fc3f@harpe.intellique.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:33:17PM +0200, Emmanuel Florac wrote:
> Le Mon, 21 Aug 2023 17:22:04 -0700
> "Darrick J. Wong" <djwong@kernel.org> écrivait:
> 
> > Hi folks,
> > 
> > I am /very/ pleased to announce that online repair for XFS is
> > completely finished.  For those of you who have been following along
> > all this time, this means that part 1 and part 2 are done!
> > 
> 
> As nobody chimed in to congratulate you, I'll tell it : you're a hero,
> Darrick :)

Thank you!!

--D

> cheers
> -- 
> ------------------------------------------------------------------------
> Emmanuel Florac     |   Direction technique
>                     |   Intellique
>                     |	<eflorac@intellique.com>
>                     |   +33 1 78 94 84 02
> ------------------------------------------------------------------------


