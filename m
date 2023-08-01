Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103F276BE31
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjHAT6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 15:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjHAT6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DDCB0;
        Tue,  1 Aug 2023 12:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9BB2616D8;
        Tue,  1 Aug 2023 19:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2C6C433C7;
        Tue,  1 Aug 2023 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690919902;
        bh=f07gtW/ggxPxV3jZuf+axoOrZ4GEOarOl1H8Rgdy2Cs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nl+Pmd0MMPMZbzkHV+8s2TH65S1ejA+Bi/v+4IzXYiUIp9t5H7VjJDevM/dN+xVHF
         zCrUTDCbG21QmLqyy36HRVtWvYt/L9p9zROLC5XmY7vqr7gAoPn05A5AQ0moWbteho
         OZQzre41wc10cr5/c1EQI8rEsqmFFfcJqXpIk6mpfcBzgoGdxZHqyVakmFFOTjHlU0
         cwqpXbeRO+EjzJKAcRMcnjbFBupMvA0O55qzqWFPHFLy1Z2Y/aYw0Ftn+wnqGN7USb
         ncoskEN+PpJmixXjJYbqN/KSRC3Cl8RF2nBFykO0iy53KfeSiFnhKzZZdle/GIiumE
         2qQ/m3COBDlXA==
Subject: [PATCH 1/3] docs: add maintainer entry profile for XFS
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     corbet@lwn.net, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, cem@kernel.org,
        sandeen@sandeen.net, chandan.babu@oracle.com, amir73il@gmail.com,
        leah.rumancik@gmail.com, zlang@kernel.org, fstests@vger.kernel.org,
        willy@infradead.org, shirley.ma@oracle.com, konrad.wilk@oracle.com
Date:   Tue, 01 Aug 2023 12:58:21 -0700
Message-ID: <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
In-Reply-To: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Create a new document to list what I think are (within the scope of XFS)
our shared goals and community roles.  Since I will be stepping down
shortly, I feel it's important to write down somewhere all the hats that
I have been wearing for the past six years.

Also, document important extra details about how to contribute to XFS.

Cc: corbet@lwn.net
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/filesystems/index.rst                |    1 
 .../filesystems/xfs-maintainer-entry-profile.rst   |  192 ++++++++++++++++++++
 .../maintainer/maintainer-entry-profile.rst        |    1 
 MAINTAINERS                                        |    1 
 4 files changed, 195 insertions(+)
 create mode 100644 Documentation/filesystems/xfs-maintainer-entry-profile.rst


diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index eb252fc972aa..09cade7eaefc 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -122,6 +122,7 @@ Documentation for filesystem implementations.
    virtiofs
    vfat
    xfs-delayed-logging-design
+   xfs-maintainer-entry-profile
    xfs-self-describing-metadata
    xfs-online-fsck-design
    zonefs
diff --git a/Documentation/filesystems/xfs-maintainer-entry-profile.rst b/Documentation/filesystems/xfs-maintainer-entry-profile.rst
new file mode 100644
index 000000000000..55d9e1fb5cd4
--- /dev/null
+++ b/Documentation/filesystems/xfs-maintainer-entry-profile.rst
@@ -0,0 +1,192 @@
+XFS Maintainer Entry Profile
+============================
+
+Overview
+--------
+XFS is a well known high-performance filesystem in the Linux kernel.
+The aim of this project is to provide and maintain a robust and
+performant filesystem.
+
+Patches are generally merged to the for-next branch of the appropriate
+git repository.
+After a testing period, the for-next branch is merged to the master
+branch.
+
+Kernel code are merged to the xfs-linux tree[0].
+Userspace code are merged to the xfsprogs tree[1].
+Test cases are merged to the xfstests tree[2].
+Ondisk format documentation are merged to the xfs-documentation tree[3].
+
+All patchsets involving XFS *must* be cc'd in their entirety to the mailing
+list linux-xfs@vger.kernel.org.
+
+Roles
+-----
+There are seven key roles in the XFS project.
+A person can take on multiple roles, and a role can be filled by
+multiple people.
+Anyone taking on a role is advised to check in with themselves and
+others on a regular basis about burnout.
+
+- **Outside Contributor**: Anyone who sends a patch but is not involved
+  in the XFS project on a regular basis.
+  These folks are usually people who work on other filesystems or
+  elsewhere in the kernel community.
+
+- **Developer**: Someone who is familiar with the XFS codebase enough to
+  write new code, documentation, and tests.
+
+  Developers can often be found in the IRC channel mentioned by the ``C:``
+  entry in the kernel MAINTAINERS file.
+
+- **Senior Developer**: A developer who is very familiar with at least
+  some part of the XFS codebase and/or other subsystems in the kernel.
+  These people collectively decide the long term goals of the project
+  and nudge the community in that direction.
+  They should help prioritize development and review work for each release
+  cycle.
+
+  Senior developers tend to be more active participants in the IRC channel.
+
+- **Reviewer**: Someone (most likely also a developer) who reads code
+  submissions to decide:
+
+  0. Is the idea behind the contribution sound?
+  1. Does the idea fit the goals of the project?
+  2. Is the contribution designed correctly?
+  3. Is the contribution polished?
+  4. Can the contribution be tested effectively?
+
+  Reviewers should identify themselves with an ``R:`` entry in the kernel
+  and fstests MAINTAINERS files.
+
+- **Testing Lead**: This person is responsible for setting the test
+  coverage goals of the project, negotiating with developers to decide
+  on new tests for new features, and making sure that developers and
+  release managers execute on the testing.
+
+  The testing lead should identify themselves with an ``M:`` entry in
+  the XFS section of the fstests MAINTAINERS file.
+
+- **Bug Triager**: Someone who examines incoming bug reports in just
+  enough detail to identify the person to whom the report should be
+  forwarded.
+
+  The bug triagers should identify themselves with a ``B:`` entry in
+  the kernel MAINTAINERS file.
+
+- **Release Manager**: This person merges reviewed patchsets into an
+  integration branch, tests the result locally, pushes the branch to a
+  public git repository, and sends pull requests further upstream.
+  This person should not be an active developer to avoid conflicts of
+  interest.
+
+  The release manager should identify themselves with an ``M:`` entry in
+  the kernel MAINTAINERS file.
+
+- **Community Manager**: This person calls and moderates meetings of as many
+  XFS participants as they can get when mailing list discussions prove
+  insufficient for collective decisionmaking.
+  They may also serve as liaison between managers of the organizations
+  sponsoring work on any part of XFS.
+
+- **LTS Maintainer**: Someone who backports and tests bug fixes from
+  uptream to the LTS kernels.
+  There tend to be six separate LTS trees at any given time.
+
+  The maintainer for a given LTS release should identify themselves with an
+  ``M:`` entry in the MAINTAINERS file for that LTS tree.
+  Unmaintained LTS kernels should be marked with status ``S: Orphan`` in that
+  same file.
+
+Submission Checklist Addendum
+-----------------------------
+Please follow these additional rules when submitting to XFS:
+
+- Patches affecting only the filesystem itself should be based against
+  the latest -rc or the for-next branch.
+  These patches will be merged back to the for-next branch.
+
+- Authors of patches touching other subsystems need to coordinate with
+  the maintainers of XFS and the relevant subsystems to decide how to
+  proceed with a merge.
+
+- Any patchset changing XFS should be cc'd in its entirety to linux-xfs.
+  Do not send partial patchsets; that makes analysis of the broader
+  context of the changes unnecessarily difficult.
+
+- Anyone making kernel changes that have corresponding changes to the
+  userspace utilities should send the userspace changes as separate
+  patchsets immediately after the kernel patchsets.
+
+- Authors of bug fix patches are expected to use fstests[2] to perform
+  an A/B test of the patch to determine that there are no regressions.
+  When possible, a new regression test case should be written for
+  fstests.
+
+- Authors of new feature patchsets must ensure that fstests will have
+  appropriate functional and input corner-case test cases for the new
+  feature.
+
+- When implementing a new feature, it is strongly suggested that the
+  developers write a design document to answer the following questions:
+
+  * **What** problem is this trying to solve?
+
+  * **Who** will benefit from this solution, and **where** will they
+    access it?
+
+  * **How** will this new feature work?  This should touch on major data
+    structures and algorithms supporting the solution at a higher level
+    than code comments.
+
+  * **What** userspace interfaces are necessary to build off of the new
+    features?
+
+  * **How** will this work be tested to ensure that it solves the
+    problems laid out in the design document without causing new
+    problems?
+
+  The design document should be committed in the kernel documentation
+  directory.
+  It may be omitted if the feature is already well known to the
+  community.
+
+- Patchsets for the new tests should be submitted as separate patchsets
+  immediately after the kernel and userspace code patchsets.
+
+- Changes to the on-disk format of XFS must be described in the ondisk
+  format document[3] and submitted as a patchset after the fstests
+  patchsets.
+
+- Patchsets implementing bug fixes and further code cleanups should put
+  the bug fixes at the beginning of the series to ease backporting.
+
+Key Release Cycle Dates
+-----------------------
+Bug fixes may be sent at any time, though the release manager may decide to
+defer a patch when the next merge window is close.
+
+Code submissions targeting the next merge window should be sent between
+-rc1 and -rc6.
+This gives the community time to review the changes, to suggest other changes,
+and for the author to retest those changes.
+
+Code submissions also requiring changes to fs/iomap and targeting the
+next merge window should be sent between -rc1 and -rc4.
+This allows the broader kernel community adequate time to test the
+infrastructure changes.
+
+Review Cadence
+--------------
+In general, please wait at least one week before pinging for feedback.
+To find reviewers, either consult the MAINTAINERS file, or ask
+developers that have Reviewed-by tags for XFS changes to take a look and
+offer their opinion.
+
+References
+----------
+| [0] https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/
+| [1] https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/
+| [2] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/
+| [3] https://git.kernel.org/pub/scm/fs/xfs/xfs-documentation.git/
diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index cfd37f31077f..6b64072d4bf2 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -105,3 +105,4 @@ to do something different in the near future.
    ../driver-api/media/maintainer-entry-profile
    ../driver-api/vfio-pci-device-specific-driver-acceptance
    ../nvme/feature-and-quirk-policy
+   ../filesystems/xfs-maintainer-entry-profile
diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..d232e9e36b87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23330,6 +23330,7 @@ S:	Supported
 W:	http://xfs.org/
 C:	irc://irc.oftc.net/xfs
 T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
+P:	Documentation/filesystems/xfs-maintainer-entry-profile.rst
 F:	Documentation/ABI/testing/sysfs-fs-xfs
 F:	Documentation/admin-guide/xfs.rst
 F:	Documentation/filesystems/xfs-delayed-logging-design.rst

