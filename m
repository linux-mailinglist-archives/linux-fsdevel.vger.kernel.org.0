Return-Path: <linux-fsdevel+bounces-3298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C784F7F2B55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAACB21BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2D482FC;
	Tue, 21 Nov 2023 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er9IllKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B3482D7;
	Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3133C433CA;
	Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700564549;
	bh=rZY+ulMh8bxnqpLPAYh/v7/pGhywr7V8s17DASQBNL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Er9IllKs/Qs2iM+Ru/pIhwnEwioB21Nkzog520Yayld52bOueQRpcFVtWyPr70Zxw
	 Cq7Pu6OG6puEUguRISTicOsZiCnEs+ZJhL6l9DpjZxaQPMHph8BiNxeDKDlc4M8XDJ
	 Pi2DDvvFm3+wVs2HCYQkP9MjLvDNCI0kJARE8QonnMbHNIpMyQKVfVojKK2IvlVTrE
	 qHnapl3zOnNpOirlpOz7pZB2raZQTgRnPwCb2WkrmWriHUgtbEGMbsViQeR70pO7Wn
	 wdQIs/SYEiH17qCNARVH4SZTMluZ0IPNbhW4jlu5SHdajEmGqPVx/xvwfqI84tbC9d
	 E5xdv1pZ5h82A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5B2C61D96;
	Tue, 21 Nov 2023 11:02:29 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 21 Nov 2023 12:02:20 +0100
Subject: [PATCH 3/3] sysclt: Clarify the results of selftest run
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20231121-jag-fix_out_of_bounds_insert-v1-3-571e76d51316@samsung.com>
References:
 <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
In-Reply-To:
 <20231121-jag-fix_out_of_bounds_insert-v1-0-571e76d51316@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Iurii Zaikin <yzaikin@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=11005;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=MnShCnR9AE1o4hhQjZ/zx4YIm4ZmH2NmKUXvce5PHIQ=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlXI5EbnQZ797U1rhU5KhJ13767soOb4JmCNUMb
 cGGS9nmvOuJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZVyORAAKCRC6l81St5ZB
 T7KMC/wKCs9llHPFGHa3JGx449TM9UgH0syBhHA9ESplocq9FOKhMfpukApsOfejArpGzkmMXKd
 +751uvyW3FqxgZg0qWwKKrJkhCxVv9Z3py7ux/YIwJ4T+3pvsTo8HVqQ6jbxVkWn7clklXEtL81
 9/eGPJ/8Rm3n0u47qxgZvKQknzHgFNsH+KVi/PE77plbQvBcIAUWCEJkwl5AURz+aB0xlyJzIj2
 AANhNdeBZES1OSW9MlXi/GOtQCETigVB6Wk6IcWPZGhk0NC3/hFYmpS2gYJ2wODDZqSydGUvLun
 rf+FXdhr9fcO3YjEucsZUU7JF2e5/DyX+LDMIS7zRSPXWawfE0hsmvKDqGbXSDQFXZ8tVPcn0gb
 eYK7t2vRp57No4AueAXFHrFQLNFHTMjUzjAIaf69GgjnHrkC4gktzaVEjTzmw8vWgoEX8v0oZ2E
 xxMVuTtGZnIOOJmX79vC2XOx0expuQPVyiQ8vEajOnd/YqY2mOg06MstglijtfQFtUqrY=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received:
 by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>

From: Joel Granados <j.granados@samsung.com>

In some cases the result of test were hidden inside the stdout and it
was difficult to identify when a test was skipped and why.

List of changes
1. Capitalize all the words that express a test result : "OK", "SKIPPED"
   and "FAIL".
2. Place all test result text at the end of the message. This will
   prevent the result from being hidden when stdout is verbose.
3. Any other explanation that comes after the result text will be placed
   in a new line.
4. All failures are marked as "FAIL"
5. Pipped the failure to stderr in tests 8, 9, 10.
6. Replaced bogus "FAIL" with "SKIPPED" in test 0007
7. All "..." are prefixed and followed by a space.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 123 ++++++++++++++++---------------
 1 file changed, 62 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index e956d2c3b7e9..84472b436c07 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -64,7 +64,7 @@ function check_production_sysctl_writes_strict()
 	else
 		old_strict=$(cat ${WRITES_STRICT})
 		if [ "$old_strict" = "1" ]; then
-			echo "ok"
+			echo "OK"
 		else
 			echo "FAIL, strict value is 0 but force to 1 to continue" >&2
 			echo "1" > ${WRITES_STRICT}
@@ -226,7 +226,7 @@ run_numerictests()
 		echo "FAIL" >&2
 		exit 1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Checking sysctl is not set to test value ... "
@@ -234,7 +234,7 @@ run_numerictests()
 		echo "FAIL" >&2
 		exit 1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Writing sysctl from shell ... "
@@ -243,7 +243,7 @@ run_numerictests()
 		echo "FAIL" >&2
 		exit 1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Resetting sysctl to original value ... "
@@ -252,7 +252,7 @@ run_numerictests()
 		echo "FAIL" >&2
 		exit 1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	# Now that we've validated the sanity of "set_test" and "set_orig",
@@ -266,7 +266,7 @@ run_numerictests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Writing middle of sysctl after synchronized seek ... "
@@ -276,7 +276,7 @@ run_numerictests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Writing beyond end of sysctl ... "
@@ -286,7 +286,7 @@ run_numerictests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Writing sysctl with multiple long writes ... "
@@ -297,14 +297,14 @@ run_numerictests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 }
 
 check_failure()
 {
-	echo -n "Testing that $1 fails as expected..."
+	echo -n "Testing that $1 fails as expected ... "
 	reset_vals
 	TEST_STR="$1"
 	orig="$(cat $TARGET)"
@@ -315,7 +315,7 @@ check_failure()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 }
@@ -357,7 +357,7 @@ run_wideint_tests()
 # Your test must accept digits 3 and 4 to use this
 run_limit_digit()
 {
-	echo -n "Checking ignoring spaces up to PAGE_SIZE works on write ..."
+	echo -n "Checking ignoring spaces up to PAGE_SIZE works on write ... "
 	reset_vals
 
 	LIMIT=$((MAX_DIGITS -1))
@@ -369,11 +369,11 @@ run_limit_digit()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
-	echo -n "Checking passing PAGE_SIZE of spaces fails on write ..."
+	echo -n "Checking passing PAGE_SIZE of spaces fails on write ... "
 	reset_vals
 
 	LIMIT=$((MAX_DIGITS))
@@ -385,7 +385,7 @@ run_limit_digit()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 }
@@ -393,7 +393,7 @@ run_limit_digit()
 # You are using an int
 run_limit_digit_int()
 {
-	echo -n "Testing INT_MAX works ..."
+	echo -n "Testing INT_MAX works ... "
 	reset_vals
 	TEST_STR="$INT_MAX"
 	echo -n $TEST_STR > $TARGET
@@ -402,11 +402,11 @@ run_limit_digit_int()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
-	echo -n "Testing INT_MAX + 1 will fail as expected..."
+	echo -n "Testing INT_MAX + 1 will fail as expected ... "
 	reset_vals
 	let TEST_STR=$INT_MAX+1
 	echo -n $TEST_STR > $TARGET 2> /dev/null
@@ -415,11 +415,11 @@ run_limit_digit_int()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
-	echo -n "Testing negative values will work as expected..."
+	echo -n "Testing negative values will work as expected ... "
 	reset_vals
 	TEST_STR="-3"
 	echo -n $TEST_STR > $TARGET 2> /dev/null
@@ -427,7 +427,7 @@ run_limit_digit_int()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 }
@@ -443,7 +443,7 @@ run_limit_digit_int_array()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
@@ -460,7 +460,7 @@ run_limit_digit_int_array()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
@@ -478,7 +478,7 @@ run_limit_digit_int_array()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
@@ -495,7 +495,7 @@ run_limit_digit_int_array()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 }
@@ -503,7 +503,7 @@ run_limit_digit_int_array()
 # You are using an unsigned int
 run_limit_digit_uint()
 {
-	echo -n "Testing UINT_MAX works ..."
+	echo -n "Testing UINT_MAX works ... "
 	reset_vals
 	TEST_STR="$UINT_MAX"
 	echo -n $TEST_STR > $TARGET
@@ -512,11 +512,11 @@ run_limit_digit_uint()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
-	echo -n "Testing UINT_MAX + 1 will fail as expected..."
+	echo -n "Testing UINT_MAX + 1 will fail as expected ... "
 	reset_vals
 	TEST_STR=$(($UINT_MAX+1))
 	echo -n $TEST_STR > $TARGET 2> /dev/null
@@ -525,11 +525,11 @@ run_limit_digit_uint()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 
-	echo -n "Testing negative values will not work as expected ..."
+	echo -n "Testing negative values will not work as expected ... "
 	reset_vals
 	TEST_STR="-3"
 	echo -n $TEST_STR > $TARGET 2> /dev/null
@@ -538,7 +538,7 @@ run_limit_digit_uint()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 	test_rc
 }
@@ -552,7 +552,7 @@ run_stringtests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Writing middle of sysctl after unsynchronized seek ... "
@@ -562,7 +562,7 @@ run_stringtests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Checking sysctl maxlen is at least $MAXLEN ... "
@@ -573,7 +573,7 @@ run_stringtests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Checking sysctl keeps original string on overflow append ... "
@@ -584,7 +584,7 @@ run_stringtests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Checking sysctl stays NULL terminated on write ... "
@@ -595,7 +595,7 @@ run_stringtests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	echo -n "Checking sysctl stays NULL terminated on overwrite ... "
@@ -606,7 +606,7 @@ run_stringtests()
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 	fi
 
 	test_rc
@@ -651,7 +651,7 @@ run_bitmaptest() {
 		fi
 	done
 
-	echo -n "Checking bitmap handler... "
+	echo -n "Checking bitmap handler ... "
 	TEST_FILE=$(mktemp)
 	echo -n "$TEST_STR" > $TEST_FILE
 
@@ -666,7 +666,7 @@ run_bitmaptest() {
 		echo "FAIL" >&2
 		rc=1
 	else
-		echo "ok"
+		echo "OK"
 		rc=0
 	fi
 	test_rc
@@ -743,89 +743,90 @@ sysctl_test_0006()
 sysctl_test_0007()
 {
 	TARGET="${SYSCTL}/$(get_test_target 0007)"
+	echo -n "Testing if $TARGET is set to 1 ... "
+
 	if [ ! -f $TARGET ]; then
-		echo "Skipping test for $TARGET as it is not present ..."
+		echo -e "SKIPPING\n$TARGET is not present"
 		return $ksft_skip
 	fi
 
 	if [ -d $DIR ]; then
-		echo "Boot param test only possible sysctl_test is built-in, not module:"
+		echo -e "SKIPPING\nTest only possible if sysctl_test is built-in, not module:"
 		cat $TEST_DIR/config >&2
 		return $ksft_skip
 	fi
 
-	echo -n "Testing if $TARGET is set to 1 ..."
 	ORIG=$(cat "${TARGET}")
 
 	if [ x$ORIG = "x1" ]; then
-		echo "ok"
+		echo "OK"
 		return 0
 	fi
-	echo "FAIL"
-	echo "Checking if /proc/cmdline contains setting of the expected parameter ..."
+
 	if [ ! -f /proc/cmdline ]; then
-		echo "/proc/cmdline does not exist, test inconclusive"
-		return 0
+		echo -e "SKIPPING\nThere is no /proc/cmdline to check for paramter"
+		return $ksft_skip
 	fi
 
 	FOUND=$(grep -c "sysctl[./]debug[./]test_sysctl[./]boot_int=1" /proc/cmdline)
 	if [ $FOUND = "1" ]; then
-		echo "Kernel param found but $TARGET is not 1, TEST FAILED"
+		echo -e "FAIL\nKernel param found but $TARGET is not 1." >&2
 		rc=1
 		test_rc
 	fi
 
-	echo "Skipping test, expected kernel parameter missing."
-	echo "To perform this test, make sure kernel is booted with parameter: sysctl.debug.test_sysctl.boot_int=1"
+	echo -e "SKIPPING\nExpected kernel parameter missing."
+	echo "Kernel must be booted with parameter: sysctl.debug.test_sysctl.boot_int=1"
 	return $ksft_skip
 }
 
 sysctl_test_0008()
 {
 	TARGET="${SYSCTL}/$(get_test_target 0008)"
+	echo -n "Testing if $TARGET is matched in kernel ... "
+
 	if [ ! -f $TARGET ]; then
-		echo "Skipping test for $TARGET as it is not present ..."
+		echo -e "SKIPPING\n$TARGET is not present"
 		return $ksft_skip
 	fi
 
-	echo -n "Testing if $TARGET is matched in kernel"
 	ORIG_VALUE=$(cat "${TARGET}")
 
 	if [ $ORIG_VALUE -ne 1 ]; then
-		echo "TEST FAILED"
+		echo "FAIL" >&2
 		rc=1
 		test_rc
 	fi
 
-	echo "ok"
+	echo "OK"
 	return 0
 }
 
 sysctl_test_0009()
 {
 	TARGET="${SYSCTL}/$(get_test_target 0009)"
-	echo -n "Testing if $TARGET unregistered correctly ..."
+	echo -n "Testing if $TARGET unregistered correctly ... "
 	if [ -d $TARGET ]; then
-		echo "TEST FAILED"
+		echo "FAIL" >&2
 		rc=1
 		test_rc
 	fi
 
-	echo "ok"
+	echo "OK"
 	return 0
 }
 
 sysctl_test_0010()
 {
 	TARGET="${SYSCTL}/$(get_test_target 0010)"
-	echo -n "Testing that $TARGET was not created  ..."
+	echo -n "Testing that $TARGET was not created ... "
 	if [ -d $TARGET ]; then
-		echo "TEST FAILED"
+		echo "FAIL" >&2
 		rc=1
 		test_rc
 	fi
 
-	echo "ok"
+	echo "OK"
 	return 0
 }
 
@@ -957,7 +958,7 @@ function skip_test()
 	if target_exists $TEST_TARGET $TEST_ID; then
 		TEST_SKIP=$(get_test_skip_no_target $TEST_ID)
 		if [[ $TEST_SKIP -eq "1" ]]; then
-			echo "Target for test $TEST_ID: $TEST_TARGET not exist, skipping test ..."
+			echo "Target $TEST_TARGET for test $TEST_ID does not exist ... SKIPPING"
 			return 0
 		fi
 	fi

-- 
2.30.2


