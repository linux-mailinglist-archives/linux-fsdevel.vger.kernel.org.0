Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF06D6A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 19:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjDDROl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjDDROg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0085A2704;
        Tue,  4 Apr 2023 10:14:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ADF26378E;
        Tue,  4 Apr 2023 17:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973F7C433A1;
        Tue,  4 Apr 2023 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680628473;
        bh=FsOURgAMeOOBIuj2i3uw5Po7ucebRoFXj4YCGwVLrvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I7N7ZAy1EBEGmuQpK02HSlrey0IX0hh4XCm3MzD1kWYS874FTk0I+jc4w7hH3N4sr
         nopeVd/YVeuILyqiVn2/ekRTuSLgDNpwDZ+C9maHwxxe+JUTqbSPGQgHlW5Gdhy3vX
         oq3RR271cLZ9FnQDLswxrl+GgpPavc1+jpWlZVmrfurz/EQ4YBVrPDwDTS9JiI3XrY
         6hcdooPFrWqMT2i2k+eCJ+zcTf2dWDJTXbKwiovKHQM3wi9z5U262EUVQx0/M+wfZd
         nCS4PJ10VfML64nfyxeFEX36paSGBSjUek8e5KcPzvRDfjBaft6o8cijLpO9UleHpX
         OPw5Tsq+IRTQg==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org,
        jack@suse.com, linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ebiggers@google.com, brauner@kernel.org, amir73il@gmail.com,
        djwong@kernel.org, anand.jain@oracle.com
Subject: [PATCH 2/5] tools/get_maintainer.pl: remove penguin chiefs
Date:   Wed,  5 Apr 2023 01:14:08 +0800
Message-Id: <20230404171411.699655-3-zlang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404171411.699655-1-zlang@kernel.org>
References: <20230404171411.699655-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's not penguin chiefs in fstests, so remove related code.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 tools/get_maintainer.pl | 45 +----------------------------------------
 1 file changed, 1 insertion(+), 44 deletions(-)

diff --git a/tools/get_maintainer.pl b/tools/get_maintainer.pl
index 376c7c02..671ffe26 100755
--- a/tools/get_maintainer.pl
+++ b/tools/get_maintainer.pl
@@ -31,7 +31,6 @@ my $email_fixes = 1;
 my $email_list = 1;
 my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
-my $email_git_penguin_chiefs = 0;
 my $email_git = 0;
 my $email_git_all_signature_types = 0;
 my $email_git_blame = 0;
@@ -79,19 +78,6 @@ my @file_emails = ();
 my %commit_author_hash;
 my %commit_signer_hash;
 
-my @penguin_chief = ();
-push(@penguin_chief, "Zorro Lang:zlang\@kernel.org");
-
-my @penguin_chief_names = ();
-foreach my $chief (@penguin_chief) {
-    if ($chief =~ m/^(.*):(.*)/) {
-	my $chief_name = $1;
-	my $chief_addr = $2;
-	push(@penguin_chief_names, $chief_name);
-    }
-}
-my $penguin_chiefs = "\(" . join("|", @penguin_chief_names) . "\)";
-
 # Signature types of people who are either
 # 	a) responsible for the code in question, or
 # 	b) familiar enough with it to give relevant feedback
@@ -242,7 +228,6 @@ if (!GetOptions(
 		'git-blame!' => \$email_git_blame,
 		'git-blame-signatures!' => \$email_git_blame_signatures,
 		'git-fallback!' => \$email_git_fallback,
-		'git-chief-penguins!' => \$email_git_penguin_chiefs,
 		'git-min-signatures=i' => \$email_git_min_signatures,
 		'git-max-maintainers=i' => \$email_git_max_maintainers,
 		'git-min-percent=i' => \$email_git_min_percent,
@@ -327,7 +312,7 @@ if ($sections || $letters ne "") {
 if ($email &&
     ($email_maintainer + $email_reviewer +
      $email_list + $email_subscriber_list +
-     $email_git + $email_git_penguin_chiefs + $email_git_blame) == 0) {
+     $email_git + $email_git_blame) == 0) {
     die "$P: Please select at least 1 email option\n";
 }
 
@@ -967,19 +952,6 @@ sub get_maintainers {
     }
 
     if ($email) {
-	foreach my $chief (@penguin_chief) {
-	    if ($chief =~ m/^(.*):(.*)/) {
-		my $email_address;
-
-		$email_address = format_email($1, $2, $email_usename);
-		if ($email_git_penguin_chiefs) {
-		    push(@email_to, [$email_address, 'chief penguin']);
-		} else {
-		    @email_to = grep($_->[0] !~ /${email_address}/, @email_to);
-		}
-	    }
-	}
-
 	foreach my $email (@file_emails) {
 	    $email = mailmap_email($email);
 	    my ($name, $address) = parse_email($email);
@@ -1041,7 +1013,6 @@ MAINTAINER field selection options:
     --git-all-signature-types => include signers regardless of signature type
         or use only ${signature_pattern} signers (default: $email_git_all_signature_types)
     --git-fallback => use git when no exact MAINTAINERS pattern (default: $email_git_fallback)
-    --git-chief-penguins => include ${penguin_chiefs}
     --git-min-signatures => number of signatures required (default: $email_git_min_signatures)
     --git-max-maintainers => maximum maintainers to add (default: $email_git_max_maintainers)
     --git-min-percent => minimum percentage of commits required (default: $email_git_min_percent)
@@ -1289,8 +1260,6 @@ sub get_maintainer_role {
 	$role = "orphan minder";
     } elsif ($role eq "obsolete") {
 	$role = "obsolete minder";
-    } elsif ($role eq "buried alive in reporters") {
-	$role = "chief penguin";
     }
 
     return $role . ":" . $subsystem;
@@ -1607,10 +1576,6 @@ sub vcs_find_signers {
     save_commits_by_author(@lines) if ($interactive);
     save_commits_by_signer(@lines) if ($interactive);
 
-    if (!$email_git_penguin_chiefs) {
-	@signatures = grep(!/${penguin_chiefs}/i, @signatures);
-    }
-
     my ($author_ref, $authors_ref) = extract_formatted_signatures(@authors);
     my ($types_ref, $signers_ref) = extract_formatted_signatures(@signatures);
 
@@ -1623,10 +1588,6 @@ sub vcs_find_author {
 
     @lines = &{$VCS_cmds{"execute_cmd"}}($cmd);
 
-    if (!$email_git_penguin_chiefs) {
-	@lines = grep(!/${penguin_chiefs}/i, @lines);
-    }
-
     return @lines if !@lines;
 
     my @authors = ();
@@ -2342,10 +2303,6 @@ sub vcs_file_blame {
 
 		@lines = &{$VCS_cmds{"execute_cmd"}}($cmd);
 
-		if (!$email_git_penguin_chiefs) {
-		    @lines = grep(!/${penguin_chiefs}/i, @lines);
-		}
-
 		last if !@lines;
 
 		my @authors = ();
-- 
2.39.2

