Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38C8637967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 13:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiKXMz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 07:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiKXMzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:55:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6C942D7
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 04:54:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A7516211E
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Nov 2022 12:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9D7C433C1;
        Thu, 24 Nov 2022 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669294478;
        bh=jpNMkvOysz5RzRNcWKi0Sjbu4ch1oCoMeyMr7MxNaOk=;
        h=Date:From:To:Cc:Subject:From;
        b=J7uzAKb5C+4LPtMcx7507VCaenogYXRYwa/KDd9rcZ2ZRw3uv8qqEfmMg6aIRotUi
         6+DTDIM/0yCHcnZYfIJVO9pHeA2sW0h/ZxPe1sdNbZW7zK/wXEOv52UxJntXEXN+Ek
         fzwPWnZSVSMJFZmalHxt46DsSiUAegpBJPyAxsneLz4+ONv5uK38p66VftD0BkMF35
         Ofn7xUz3yo++KcFnTJ4+352KjsRo6WZjHHzZljo2vuRmoLB6U5UG79A2x0zIPBqDWh
         Zd0MmwtymSE7Ko0NQQrpeSEXPLk8fSjcDcJajLIEHyHlE7vADLkTDD3PfeiwCpJzgo
         5uRe8JbzDVFjg==
Date:   Thu, 24 Nov 2022 13:54:34 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     daniel@iogearbox.net, stgraber@ubuntu.com
Subject: FOSDEM 2023: Kernel Devroom CfP
Message-ID: <20221124125434.rhuagels7jrru4dc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

We are pleased to announce the Call for Participation (CFP) for the FOSDEM 2023
Kernel Devroom.

FOSDEM 2023 will be over the weekend of the 4th and 5th of February in Brussels,
Belgium. FOSDEM is a free and non-commercial event organized by the community for
the community. The goal is to provide free and open source software developers and
communities a place to meet to:

* Get in touch with other developers and projects;
* Be informed about the latest developments in the free software world;
* Be informed about the latest developments in the open source world;
* Attend interesting talks and presentations on various topics by project leaders
   and committers;
* To promote the development and benefits of free software and open source solutions.
* Participation and attendance is totally free, though the organizers gratefully
   accept donations and sponsorship.

## Format

The Kernel Devroom will be running all day on Sunday, 5 February, starting at 9am
and finishing at 5pm.

We're looking for talk or demo proposals in one of the following 4 sizes:

   10 minutes (e.g., a short demo)
   20 minutes (e.g., a project update)
   30 minutes (e.g., introduction to a new technology or a deep dive on a complex feature)
   40 minutes (e.g., a deep dive on a complex feature)

In all cases, please allow for at least 5 minutes of questions (10 min preferred for
the 30 min slots). In general, shorter content will be more likely to get approved as
we want to cover a wide range of topics.

## Proposals

Proposals should be sent through the FOSDEM scheduling system at:
https://penta.fosdem.org/submission/FOSDEM23/ Note that if you submitted a proposal to
FOSDEM in the past, you can and should re-use your existing account rather than register
a new one. If you have no account yet please create a new one. Make sure to fill in your
speaker bio.

Please select the "Kernel" as the track and ensure you include the following information
when submitting a proposal:

| Section | Field	| Notes                                                                           |
| ------- | ----------- | ------------------------------------------------------------------------------- |
| Person  | Name(s)	| Your first, last and public names.                                              |
| Person  | Abstract	| A short bio.                                                                    |
| Person  | Photo	| Please provide a photo.                                                         |
| Event	  | Event Title	| This is the title of your talk - please be descriptive to encourage attendance. |
| Event	  | Abstract	| Short abstract of one or two paragraphs.                                        |
| Event	  | Duration	| Please indicate the length of your talk; 10 min, 20 min, 30, or 40 min          |

The CFP deadline is Saturday, 10 December 2022.

## Topics

The Kernel Devroom aims to cover a wide range of different topics so don't be shy. The following
list should just serve as an inspiration:

   * Filesystems and Storage
   * io_uring
   * Tracing
   * eBPF
   * Fuzzing
   * System Boot
   * Security
   * Networking
   * Namespaces and Cgroups
   * Virtualization
   * Rust in the Linux Kernel

## Code of Conduct

We'd like to remind all speakers and attendees that all of the presentations and discussions in
our devroom are held under the guidelines set in the FOSDEM Code of Conduct and we expect attendees,
speakers, and volunteers to follow the CoC at all times.

If you submit a proposal and it is accepted, you will be required to confirm that you accept the
FOSDEM CoC. If you have any questions about the CoC or wish to have one of the devroom organizers
review your presentation slides or any other content for CoC compliance, please email us and we will
do our best to assist you.

Thanks!
Daniel Borkmann
Stéphane Graber
Christian Brauner
